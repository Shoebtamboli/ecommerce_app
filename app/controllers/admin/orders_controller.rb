class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_order, only: [:edit, :update]
  layout 'admin'

  def index
    @orders = Order.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  private

  def check_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end