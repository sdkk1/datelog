FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "美味しそうですね！" }
    rate { 5 }
    association :user
    association :datespot
  end
end
