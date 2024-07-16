class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_items
    cart_items.sum(:quantity)
  end

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end
end