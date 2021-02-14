FactoryBot.define do
  factory :entry do
    user_id { 1 }
    room_id { 1 }
    association :user
    association :room
  end
end
