class SendOrderConfirmationEmailJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    Rails.logger.info "Starting SendOrderConfirmationEmailJob for Order ##{order_id}"
    
    order = Order.find_by(id: order_id)
    if order
      Rails.logger.info "Found Order ##{order_id}, sending confirmation email"
      OrderMailer.confirmation_email(order_id).deliver_now
      Rails.logger.info "Confirmation email sent for Order ##{order_id}"
    else
      Rails.logger.error "Order ##{order_id} not found"
    end
  end
end