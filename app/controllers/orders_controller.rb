class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart, only: [:new, :create]

  def new
    @cart = current_user.cart
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(status: 'pending')
    @cart = current_user.cart

    if @order.save
      @cart.cart_items.each do |cart_item|
        @order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end

      @order.update(total: @order.total_price)
      @cart.destroy
      # Enqueue the job to send the confirmation email
      SendOrderConfirmationEmailJob.perform_later(@order.id)
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def check_cart
    unless current_user.cart && current_user.cart.cart_items.any?
      redirect_to products_path, alert: 'Your cart is empty. Please add some products before checking out.'
    end
  end
end