require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:cart) { Cart.create(user: user) }
  let(:product) do
    product = Product.new(name: 'Test Product', price: 10, stock: 5)
    product.thumbnail.attach(io: StringIO.new("dummy image"), filename: "test_image.jpg", content_type: "image/jpeg")
    product.save!
    product
  end

  it "is valid with valid attributes" do
    expect(cart).to be_valid
  end

  it "belongs to a user" do
    expect(Cart.reflect_on_association(:user).macro).to eq :belongs_to
  end

  it "has many cart items" do
    expect(Cart.reflect_on_association(:cart_items).macro).to eq :has_many
  end

  it "has many products through cart items" do
    expect(Cart.reflect_on_association(:products).macro).to eq :has_many
  end

  describe "#total_items" do
    it "returns the total number of items in the cart" do
      cart.cart_items.create(product: product, quantity: 2)
      cart.cart_items.create(product: product, quantity: 3)
      expect(cart.total_items).to eq(5)
    end
  end

  describe "#total_price" do
    it "returns the total price of all items in the cart" do
      cart.cart_items.create(product: product, quantity: 2)
      expect(cart.total_price).to eq(20)
    end
  end
end