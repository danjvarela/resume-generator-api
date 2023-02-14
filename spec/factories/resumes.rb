FactoryBot.define do
  sequence :resume_title do |rt|
    "title#{rt}"
  end
  factory :resume do
    title { generate :resume_title }
    headline { "MyString" }
    summary { "MyString" }
    user { association :user }
  end
end
