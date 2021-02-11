FactoryBot.define do
  factory :entry do
    user_id { 1 }
    room_id { 1 }
    content { "初めまして！" }
    association :user
    association :room
  end
end
