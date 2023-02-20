FactoryBot.define do
  factory :education do
    level { 1 }
    field_of_study { "MyString" }
    school { association :school, strategy: :create }
    start_date { Date.today - 3.years }
    end_date { Date.today }
    user { association :user }
  end
end
