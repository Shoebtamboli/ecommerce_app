class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  #after_create :create_cart

  def create_cart
    Cart.create(user: self)
  end

  private

  def set_default_role
    self.role ||= :user
  end
end