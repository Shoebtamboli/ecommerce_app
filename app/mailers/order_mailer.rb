class OrderMailer < ApplicationMailer
  def confirmation_email(order_id)
    @order = Order.find(order_id)
    @user = @order.user
    mail(to: @user.email, subject: "Order Confirmation - Order ##{@order.id}")
  end

  def status_update_email(order, old_status)
    @order = order
    @user = @order.user
    @old_status = old_status
    mail(to: @user.email, subject: "Order Status Updated - Order ##{@order.id}")
  end
end