require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:valid_attributes) do
    {
      name: "Test Product",
      price: 10,
      stock: 5
    }
  end

  it "is valid with valid attributes" do
    product = Product.new(valid_attributes)
    product.thumbnail.attach(io: StringIO.new("dummy image"), filename: "test_image.jpg", content_type: "image/jpeg")
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    product = Product.new(valid_attributes.merge(name: nil))
    expect(product).to_not be_valid
  end

  it "is not valid without a price" do
    product = Product.new(valid_attributes.merge(price: nil))
    expect(product).to_not be_valid
  end

  it "is not valid with a negative price" do
    product = Product.new(valid_attributes.merge(price: -1))
    expect(product).to_not be_valid
  end

  it "is not valid without stock" do
    product = Product.new(valid_attributes.merge(stock: nil))
    expect(product).to_not be_valid
  end

  it "is not valid with negative stock" do
    product = Product.new(valid_attributes.merge(stock: -1))
    expect(product).to_not be_valid
  end

  it "is not valid without a thumbnail" do
    product = Product.new(valid_attributes)
    expect(product).to_not be_valid
    expect(product.errors[:thumbnail]).to include("must be attached")
  end

  it "is not valid with a large thumbnail" do
    product = Product.new(valid_attributes)
    product.thumbnail.attach(io: StringIO.new("a" * 1.1.megabytes), filename: "large_image.jpg", content_type: "image/jpeg")
    expect(product).to_not be_valid
    expect(product.errors[:thumbnail]).to include("is too big")
  end

  it "is not valid with an invalid thumbnail format" do
    product = Product.new(valid_attributes)
    product.thumbnail.attach(io: StringIO.new("dummy text file"), filename: "test_file.txt", content_type: "text/plain")
    expect(product).to_not be_valid
    expect(product.errors[:thumbnail]).to include("must be a JPEG or PNG")
  end
end