FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    company { association :company }
    start_date { Date.today - 3.years }
    end_date { Date.today }
    city { Faker::Address.city }
    description { nil }
    user { association :user }
  end
end
