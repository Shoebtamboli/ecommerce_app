class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    @cart_item.quantity ||= 0
    @cart_item.quantity += 1

    if @cart_item.save
      redirect_back fallback_location: root_path, notice: 'Item added to cart.'
    else
      redirect_back fallback_location: root_path, alert: 'Error adding item to cart.'
    end
  end

  def remove_item
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  def update_quantity
    @cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i
    if new_quantity > 0
      @cart_item.update(quantity: new_quantity)
      redirect_to cart_path, notice: 'Quantity updated.'
    else
      redirect_to cart_path, alert: 'Quantity must be at least 1.'
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end