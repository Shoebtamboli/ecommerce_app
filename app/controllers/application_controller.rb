class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :ensure_cart_exists

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      super
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def ensure_cart_exists
    if user_signed_in? && !current_user.cart
      current_user.create_cart
    end
  end
end