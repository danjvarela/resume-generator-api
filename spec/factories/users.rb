FactoryBot.define do
  factory :user do
    name { generate :user_name }
    email { Faker::Internet.email name: name }
    password { "password" }
    confirmed_at { Time.now }
  end
end
