FactoryBot.define do
  factory :favorite do
    association :user
    association :datespot
  end
end
