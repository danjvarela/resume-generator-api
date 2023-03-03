FactoryBot.define do
  factory :user do
    name { generate :user_name }
    email { Faker::Internet.email name: name }
    password { "password" }
    phone_number { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    confirmed_at { Time.now }
  end
end
