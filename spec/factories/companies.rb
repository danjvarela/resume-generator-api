FactoryBot.define do
  factory :company do
    name { generate :company_name }
  end
end
