FactoryBot.define do
  factory :job do
    title { generate :job_title }
    company { association :company, strategy: :create }
    start_date { Date.today - 3.years }
    end_date { Date.today }
    city { generate :city }
    description { nil }
    user { association :user, strategy: :create }
  end
end
