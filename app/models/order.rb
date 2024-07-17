class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  
  enum status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled' }
  
  def total_price
    order_items.sum { |item| item.quantity * item.price }
  end
end