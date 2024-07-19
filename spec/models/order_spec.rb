require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:order) { Order.create(user: user) }
  let(:product) do
    product = Product.new(name: 'Test Product', price: 10, stock: 5)
    product.thumbnail.attach(io: StringIO.new("dummy image"), filename: "test_image.jpg", content_type: "image/jpeg")
    product.save!
    product
  end

  it { should belong_to(:user) }
  it { should have_many(:order_items) }
  
  it "defines status as an enum with correct values" do
    expect(Order.statuses).to eq({
      "pending" => "pending",
      "completed" => "completed",
      "cancelled" => "cancelled"
    })
  end

  describe "#total_price" do
    it "returns the total price of all items in the order" do
      order.order_items.create!(product: product, quantity: 2, price: product.price)
      expect(order.total_price).to eq(20)
    end
  end
end