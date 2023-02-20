FactoryBot.define do
  factory :school do
    name { generate :school_name }
    location { Faker::Address.city }
  end
end
