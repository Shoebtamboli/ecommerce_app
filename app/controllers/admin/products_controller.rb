class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_product, only: [:edit, :update, :destroy]
  layout 'admin'

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  private

  def check_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :thumbnail)
  end
end