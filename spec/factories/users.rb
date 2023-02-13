FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email name: name }
    password { "password" }
    confirmed_at { Time.now }
  end
end
