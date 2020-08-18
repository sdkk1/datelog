FactoryBot.define do
  factory :notification do
    datespot_id { 1 }
    variety { 1 }
    content { "" }
    from_user_id { 2 }
    association :user
    association :datespot
  end
end
