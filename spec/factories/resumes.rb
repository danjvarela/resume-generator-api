FactoryBot.define do
  factory :resume do
    title { generate :resume_title }
    headline { "Some Headline" }
    summary { "Some Summary" }
    user { association :user }
  end
end
