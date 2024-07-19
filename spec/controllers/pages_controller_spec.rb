require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    it "returns a success response" do
      get :home
      expect(response).to be_successful
    end

    it "assigns @featured_products" do
      products = create_list(:product, 5)
      get :home
      expect(assigns(:featured_products).count).to eq(4)
    end
  end

  describe "GET #about" do
    it "returns a success response" do
      get :about
      expect(response).to be_successful
    end
  end

  describe "GET #contact" do
    it "returns a success response" do
      get :contact
      expect(response).to be_successful
    end

    it "assigns a new ContactSubmission to @contact_submission" do
      get :contact
      expect(assigns(:contact_submission)).to be_a_new(ContactSubmission)
    end
  end

  describe "POST #submit_contact" do
    context "with valid params" do
      it "creates a new ContactSubmission" do
        expect {
          post :submit_contact, params: { contact_submission: attributes_for(:contact_submission) }
        }.to change(ContactSubmission, :count).by(1)
      end

      it "redirects to the contact page" do
        post :submit_contact, params: { contact_submission: attributes_for(:contact_submission) }
        expect(response).to redirect_to(contact_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'contact' template)" do
        post :submit_contact, params: { contact_submission: attributes_for(:contact_submission, email: nil) }
        expect(response).to be_successful
      end
    end
  end
end