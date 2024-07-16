class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  layout 'admin'

  def index
    @total_products = Product.count
    @out_of_stock_products = Product.where(stock: 0).count
  end

  private

  def check_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end
end