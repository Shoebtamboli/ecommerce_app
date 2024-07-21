require 'rails_helper'

RSpec.describe "Devise views", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Sign up" do
    before { visit new_user_registration_path }

    it "displays the sign up form" do
      expect(page).to have_content("Create your account")
      expect(page).to have_field("Email address")
      expect(page).to have_field("Password")
      expect(page).to have_field("Confirm password")
      expect(page).to have_button("Sign up")
    end

    it "signs up a new user with valid information" do
      fill_in "Email address", with: "newuser@example.com"
      fill_in "Password", with: "password123"
      fill_in "Confirm password", with: "password123"

      expect {
        click_button "Sign up"
      }.to change(User, :count).by(1)

      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    it "shows error messages with invalid information" do
      click_button "Sign up"

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end

  describe "Sign in" do
    let!(:user) { create(:user, email: "existinguser@example.com", password: "password123") }

    before { visit new_user_session_path }

    it "displays the sign in form" do
      expect(page).to have_content("Sign in to your account")
      expect(page).to have_field("Email address")
      expect(page).to have_field("Password")
      expect(page).to have_button("Sign in")
    end

    it "signs in an existing user with valid credentials" do
      fill_in "Email address", with: "existinguser@example.com"
      fill_in "Password", with: "password123"
      click_button "Sign in"

      expect(page).to have_content("Signed in successfully.")
    end

    it "shows an error message with invalid credentials" do
      fill_in "Email address", with: "existinguser@example.com"
      fill_in "Password", with: "wrongpassword"
      click_button "Sign in"

      expect(page).to have_content("Invalid Email or password.")
    end

    it "has a 'Remember me' checkbox" do
      expect(page).to have_field("Remember me")
    end

    it "has a 'Forgot your password?' link" do
      expect(page).to have_link("Forgot your password?", href: new_user_password_path)
    end
  end

  describe "Password reset" do
    before { visit new_user_password_path }

    it "displays the password reset form" do
      expect(page).to have_content("Forgot your password?")
      expect(page).to have_content("Enter your email address and we'll send you password reset instructions.")
      expect(page).to have_field("Email address")
      expect(page).to have_button("Send reset instructions")
    end

    it "sends password reset instructions for an existing email" do
      user = create(:user)
      fill_in "Email address", with: user.email
      
      expect {
        click_button "Send reset instructions"
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
    end
  end

  describe "Edit user" do
    let(:user) { create(:user) }

    before do
      sign_in user
      visit edit_user_registration_path
    end

    it "displays the edit user form" do
      expect(page).to have_content("Edit User")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password", type: 'password')
      expect(page).to have_field("Password confirmation", type: 'password')
      expect(page).to have_field("Current password")
      expect(page).to have_button("Update")
    end

    it "updates user information with valid data" do
      fill_in "Email", with: "newemail@example.com"
      fill_in "Current password", with: user.password
      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully.")
    end

    it "shows error messages with invalid information" do
      fill_in "Email", with: ""
      click_button "Update"

      expect(page).to have_content("Email can't be blank")
    end

    it "has a 'Cancel my account' button" do
      expect(page).to have_button("Cancel my account")
    end
  end

  describe "Change password" do
    let(:user) { create(:user) }
    let(:token) { user.send_reset_password_instructions }

    before do
      visit edit_user_password_path(reset_password_token: token)
    end

    it "displays the change password form" do
      expect(page).to have_content("Change your password")
      expect(page).to have_field("New password")
      expect(page).to have_field("Confirm new password")
      expect(page).to have_button("Change my password")
    end

    it "changes the password with valid information" do
      fill_in "New password", with: "newpassword123"
      fill_in "Confirm new password", with: "newpassword123"
      click_button "Change my password"

      expect(page).to have_content("Your password has been changed successfully.")
    end

    it "shows error messages with invalid information" do
      click_button "Change my password"

      expect(page).to have_content("Password can't be blank")
    end
  end
end