require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "is valid with valid attributes" do
    cart = Cart.create(user: User.create(email: 'test@example.com', password: 'password'))
    product = Product.create(name: 'Test Product', price: 10, stock: 5)
    cart_item = CartItem.new(cart: cart, product: product, quantity: 1)
    expect(cart_item).to be_valid
  end

  it "is not valid without a quantity" do
    cart_item = CartItem.new(quantity: nil)
    expect(cart_item).to_not be_valid
  end

  it "is not valid with a quantity less than or equal to 0" do
    cart_item = CartItem.new(quantity: 0)
    expect(cart_item).to_not be_valid
  end

  it "belongs to a cart" do
    assc = described_class.reflect_on_association(:cart)
    expect(assc.macro).to eq :belongs_to
  end

  it "belongs to a product" do
    assc = described_class.reflect_on_association(:product)
    expect(assc.macro).to eq :belongs_to
  end
end