require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product) { create(:product) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show
      expect(response).to be_successful
    end
  end

  describe "POST #add_item" do
    it "adds an item to the cart" do
      expect {
        post :add_item, params: { product_id: product.id }
      }.to change(CartItem, :count).by(1)
    end

    it "redirects back" do
      post :add_item, params: { product_id: product.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #remove_item" do
    let!(:cart_item) { create(:cart_item, cart: cart, product: product) }

    it "removes an item from the cart" do
      expect {
        delete :remove_item, params: { id: cart_item.id }
      }.to change(CartItem, :count).by(-1)
    end

    it "redirects to cart path" do
      delete :remove_item, params: { id: cart_item.id }
      expect(response).to redirect_to(cart_path)
    end
  end

  describe "PATCH #update_quantity" do
    let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }

    it "updates the quantity of an item in the cart" do
      patch :update_quantity, params: { id: cart_item.id, quantity: 3 }
      expect(cart_item.reload.quantity).to eq(3)
    end

    it "redirects to cart path" do
      patch :update_quantity, params: { id: cart_item.id, quantity: 3 }
      expect(response).to redirect_to(cart_path)
    end
  end
end