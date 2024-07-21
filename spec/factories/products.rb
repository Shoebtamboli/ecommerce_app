FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { "A great product" }
    price { rand(10.0..100.0).round(2) }
    stock { rand(1..100) }

    after(:build) do |product|
      product.thumbnail.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end