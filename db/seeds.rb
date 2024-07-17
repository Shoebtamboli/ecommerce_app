require 'open-uri'
require 'faker'

# Clear existing data
puts "Clearing existing data..."
User.destroy_all
Product.destroy_all
Order.destroy_all

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
    end
  end
end

# Create admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: :admin
)
puts "Created admin user: #{admin.email}"

# Create regular users
10.times do |i|
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
  puts "Created user #{i+1}: #{user.email}"
end

# Create products
puts "Creating 50 products..."
50.times do |i|
  Product.transaction do
    product = Product.new(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 4),
      price: Faker::Commerce.price(range: 10..1000.0),
      stock: Faker::Number.between(from: 0, to: 100)
    )

    # Attach thumbnail
    thumbnail_url = "https://picsum.photos/seed/#{product.name.parameterize}/300/300"
    attach_image(product, thumbnail_url, true)

    # Attach additional images (1 to 3 images)
    image_count = Faker::Number.between(from: 1, to: 3)
    image_count.times do |j|
      image_url = "https://picsum.photos/seed/#{product.name.parameterize}#{j}/800/600"
      attach_image(product, image_url)
    end

    if product.save
      puts "Created product #{i+1}: #{product.name}"
    else
      puts "Failed to create product #{i+1}: #{product.errors.full_messages.join(', ')}"
    end
  end
end

# Create orders
puts "Creating orders..."
User.where(role: :user).each do |user|
  rand(1..5).times do |i|
    order = Order.new(user: user, status: Order.statuses.keys.sample)
    rand(1..5).times do
      product = Product.all.sample
      quantity = rand(1..3)
      order.order_items.build(product: product, quantity: quantity, price: product.price)
    end
    order.total = order.order_items.sum { |item| item.quantity * item.price }
    if order.save
      puts "Created order #{i+1} for user: #{user.email}"
    else
      puts "Failed to create order for user: #{user.email}"
    end
  end
end

puts "Seed data creation completed!"