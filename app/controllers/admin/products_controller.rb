class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_product, only: [:edit, :update, :destroy, :remove_image]
  layout 'admin'

  def index
    @products = Product.order(created_at: :desc).page(params[:page]).per(10)
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
    begin
      ActiveRecord::Base.transaction do
        @product.destroy!
      end
      redirect_to admin_products_path, notice: 'Product was successfully deleted.'
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_products_path, alert: "Failed to delete product: #{e.message}"
    end
  end

  def remove_image
    image = @product.images.find(params[:image_id])
    image.purge
    redirect_to edit_admin_product_path(@product), notice: 'Image was successfully removed.'
  end

  private

  def check_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :thumbnail, images: [], images_to_remove: [])
  end
end