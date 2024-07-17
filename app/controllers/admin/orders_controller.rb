class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_order, only: [:show, :edit, :update]
  layout 'admin'

  def index
    @orders = Order.all
    
    # Filter by order ID
    @orders = @orders.where(id: params[:order_id]) if params[:order_id].present?
    
    # Filter by status
    @orders = @orders.where(status: params[:status]) if params[:status].present?
    
    # Filter by date range
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @orders = @orders.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    end

    @orders = @orders.order(created_at: :desc).page(params[:page])
  end

  def show
    # The @order instance variable is already set by the set_order before_action
  end

  def edit
  end

  def update
    old_status = @order.status
    if @order.update(order_params)
      if @order.status != old_status
        # Send email about status update
        SendOrderStatusUpdateEmailJob.perform_later(@order.id, old_status)
      end
      redirect_to admin_order_path(@order), notice: 'Order was successfully updated.'
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