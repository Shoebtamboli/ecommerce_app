require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product) { create(:product) }

  before do
    sign_in user
    create(:cart_item, cart: cart, product: product, quantity: 2)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @orders" do
      order = create(:order, user: user)
      get :index
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new Order to @order" do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  describe "POST #create" do
    it "creates a new Order" do
      expect {
        post :create
      }.to change(Order, :count).by(1)
    end

    it "creates OrderItems" do
      expect {
        post :create
      }.to change(OrderItem, :count).by(1)
    end

    it "destroys the cart" do
      expect {
        post :create
      }.to change(Cart, :count).by(-1)
    end

    it "redirects to the created order" do
      post :create
      expect(response).to redirect_to(Order.last)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      order = create(:order, user: user)
      get :show, params: { id: order.to_param }
      expect(response).to be_successful
    end
  end
end