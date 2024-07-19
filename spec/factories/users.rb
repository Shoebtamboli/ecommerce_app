FactoryBot.define do
  factory :user do
    # Add necessary attributes here
    email { "test@example.com" }
    password { "password" }
    role { :user }

    trait :admin do
      role { :admin }
    end
  end
end
