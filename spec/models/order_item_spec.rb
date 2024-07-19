require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it "belongs to an order" do
    assc = described_class.reflect_on_association(:order)
    expect(assc.macro).to eq :belongs_to
  end

  it "belongs to a product" do
    assc = described_class.reflect_on_association(:product)
    expect(assc.macro).to eq :belongs_to
  end
end