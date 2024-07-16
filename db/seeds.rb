# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

# Clear existing data
puts "Clearing existing data..."
Product.destroy_all

puts "Creating products..."

products = [
  {
    name: "Laptop",
    description: "High-performance laptop for work and gaming",
    price: 999.99,
    stock: 50,
    thumbnail_url: "https://picsum.photos/seed/laptop/300/300",
    image_urls: [
      "https://picsum.photos/seed/laptop1/800/600",
      "https://picsum.photos/seed/laptop2/800/600",
      "https://picsum.photos/seed/laptop3/800/600"
    ]
  },
  {
    name: "Smartphone",
    description: "Latest model with advanced features",
    price: 699.99,
    stock: 100,
    thumbnail_url: "https://picsum.photos/seed/smartphone/300/300",
    image_urls: [
      "https://picsum.photos/seed/smartphone1/800/600",
      "https://picsum.photos/seed/smartphone2/800/600",
      "https://picsum.photos/seed/smartphone3/800/600"
    ]
  },
  {
    name: "Headphones",
    description: "Noise-cancelling wireless headphones",
    price: 199.99,
    stock: 200,
    thumbnail_url: "https://picsum.photos/seed/headphones/300/300",
    image_urls: [
      "https://picsum.photos/seed/headphones1/800/600",
      "https://picsum.photos/seed/headphones2/800/600",
      "https://picsum.photos/seed/headphones3/800/600"
    ]
  }
]

def attach_image(product, url, is_thumbnail = false)
  max_attempts = 3
  attempts = 0

  begin
    attempts += 1
    image = URI.open(url)
    if is_thumbnail
      product.thumbnail.attach(io: image, filename: "#{product.name.parameterize}_thumbnail.jpg")
    else
      product.images.attach(io: image, filename: "#{product.name.parameterize}_image_#{product.images.count + 1}.jpg")
    end
  rescue OpenURI::HTTPError, SocketError => e
    if attempts < max_attempts
      puts "Error downloading image, retrying... (#{attempts}/#{max_attempts})"
      sleep 1
      retry
    else
      puts "Failed to download image after #{max_attempts} attempts: #{url}"
      raise e
    end
  end
end

products.each do |product_data|
  Product.transaction do
    product = Product.new(
      name: product_data[:name],
      description: product_data[:description],
      price: product_data[:price],
      stock: product_data[:stock]
    )

    # Attach thumbnail
    attach_image(product, product_data[:thumbnail_url], true)

    # Attach additional images
    product_data[:image_urls].each do |image_url|
      attach_image(product, image_url)
    end

    if product.save
      puts "Created #{product.name}"
    else
      puts "Failed to create #{product_data[:name]}: #{product.errors.full_messages.join(', ')}"
    end
  end
end

puts "Seed data creation completed!"