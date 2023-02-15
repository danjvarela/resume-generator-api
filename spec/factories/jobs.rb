FactoryBot.define do
  factory :job do
    title { Faker::Lorem.characters }
    company { association :company, strategy: :create }
    start_date { Date.today - 3.years }
    end_date { Date.today }
    city { Faker::Lorem.characters }
    description { nil }
    user { association :user, strategy: :create }
  end
end
