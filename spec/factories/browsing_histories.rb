FactoryBot.define do
  factory :browsing_history do
    association :user
    association :datespot
  end
end
