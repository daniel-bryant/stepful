FactoryBot.define do
  factory :student do
    name { "Brendon Small" }
    sequence(:phone) { |n| "202555123#{n}" }
  end
end
