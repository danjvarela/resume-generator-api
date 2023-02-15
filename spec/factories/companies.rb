FactoryBot.define do
  factory :company do
    name { Faker::Lorem.characters }
  end
end
