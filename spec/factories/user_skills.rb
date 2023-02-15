FactoryBot.define do
  factory :user_skill do
    user { association :user, strategy: :create }
    skill { association :skill, strategy: :create }
    years_of_experience { Faker::Number.between(from: 1, to: 10) }
  end
end
