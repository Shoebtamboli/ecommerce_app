require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(email: "test@example.com", password: "password")
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with an invalid email format" do
    user = User.new(email: "invalid_email")
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end

  it "has a default role of user" do
    user = User.create(email: "test@example.com", password: "password")
    expect(user.role).to eq("user")
  end

  it "can have an admin role" do
    user = User.create(email: "admin@example.com", password: "password", role: :admin)
    expect(user.role).to eq("admin")
  end

  it "has one cart" do
    assc = described_class.reflect_on_association(:cart)
    expect(assc.macro).to eq :has_one
  end

  it "has many orders" do
    assc = described_class.reflect_on_association(:orders)
    expect(assc.macro).to eq :has_many
  end

  describe "#create_cart" do
    it "creates a new cart for the user" do
      user = User.create(email: "test@example.com", password: "password")
      expect { user.create_cart }.to change { Cart.count }.by(1)
      expect(user.cart).to be_present
    end
  end
end