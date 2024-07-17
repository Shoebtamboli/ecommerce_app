class PagesController < ApplicationController
  def home
    @featured_products = Product.order(created_at: :desc).limit(4)
    # Add any other instance variables you need for the homepage
  end
end