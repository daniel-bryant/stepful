FactoryBot.define do
  factory :coach do
    name { "John McGuirk" }
    sequence(:phone) { |n| "202555123#{n}" }
  end
end
