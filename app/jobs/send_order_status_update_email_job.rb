class SendOrderStatusUpdateEmailJob < ApplicationJob
  queue_as :default

  def perform(order_id, old_status)
    order = Order.find_by(id: order_id)
    if order
      OrderMailer.status_update_email(order, old_status).deliver_now
    else
      Rails.logger.error "Failed to send status update email. Order ##{order_id} not found."
    end
  end
end