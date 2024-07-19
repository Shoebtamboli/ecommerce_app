require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: :admin) }
  let(:product) { create(:product) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "filters products by search term" do
      product1 = create(:product, name: "Apple")
      product2 = create(:product, name: "Banana")
      get :index, params: { search: "Apple" }
      expect(assigns(:products)).to include(product1)
      expect(assigns(:products)).not_to include(product2)
    end

    it "filters products by price range" do
      product1 = create(:product, price: 10)
      product2 = create(:product, price: 20)
      get :index, params: { min_price: 15, max_price: 25 }
      expect(assigns(:products)).to include(product2)
      expect(assigns(:products)).not_to include(product1)
    end

    it "sorts products by price ascending" do
      product1 = create(:product, price: 20)
      product2 = create(:product, price: 10)
      get :index, params: { sort_by: 'price_asc' }
      expect(assigns(:products).first).to eq(product2)
      expect(assigns(:products).last).to eq(product1)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    context "when user is admin" do
      before { sign_in admin }

      it "returns a success response" do
        get :new
        expect(response).to be_successful
      end
    end

    context "when user is not admin" do
      before { sign_in user }

      it "redirects to root path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "when user is admin" do
      before { sign_in admin }

      context "with valid params" do
        it "creates a new Product" do
          expect {
            post :create, params: { product: attributes_for(:product) }
          }.to change(Product, :count).by(1)
        end

        it "redirects to the created product" do
          post :create, params: { product: attributes_for(:product) }
          expect(response).to redirect_to(Product.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { product: attributes_for(:product, name: nil) }
          expect(response).to be_successful
        end
      end
    end
  end

  # Similarly, you can add tests for edit, update, and destroy actions
end