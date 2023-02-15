FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters }
    email { Faker::Internet.email name: name }
    password { "password" }
    confirmed_at { Time.now }
  end
end
