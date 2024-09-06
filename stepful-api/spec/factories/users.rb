FactoryBot.define do
  factory :user do
    type { "Coach" }
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:phone) { |n| "202555123#{n}" }
  end
end
