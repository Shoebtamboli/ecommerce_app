require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: "Hello World"
    end
  end

  let(:user) { create(:user) }
  let(:admin) { create(:user, role: :admin) }

  describe "#after_sign_in_path_for" do
    it "redirects admin to admin dashboard" do
      sign_in admin
      expect(controller.after_sign_in_path_for(admin)).to eq(admin_dashboard_path)
    end

    it "redirects regular user to root path" do
      sign_in user
      expect(controller.after_sign_in_path_for(user)).to eq(root_path)
    end
  end

  describe "#ensure_cart_exists" do
    it "creates a cart for signed in user without a cart" do
      sign_in user
      expect {
        get :index
      }.to change { user.reload.cart }.from(nil).to(be_a(Cart))
    end

    it "does not create a cart for signed in user with a cart" do
      create(:cart, user: user)
      sign_in user
      expect {
        get :index
      }.not_to change(Cart, :count)
    end
  end
end
