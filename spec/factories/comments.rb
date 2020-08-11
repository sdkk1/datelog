FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "美味しそうですね！" }
    association :datespot
  end
end
