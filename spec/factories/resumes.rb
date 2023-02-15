FactoryBot.define do
  factory :resume do
    title { Faker::Lorem.characters }
    headline { "MyString" }
    summary { "MyString" }
    user { association :user }
  end
end
