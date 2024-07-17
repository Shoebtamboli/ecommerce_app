require 'open-uri'
require 'faker'

# Clear existing data
puts "Clearing existing data..."
Product.destroy_all

puts "Creating 50 products..."

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

puts "Seed data creation completed!"