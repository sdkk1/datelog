FactoryBot.define do
  factory :datespot do
    name { Faker::Restaurant.name }
    address { "東京都渋谷区恵比寿西" }
    prefecture_code { 13 }
    range { 0 }
    tag_list { "オシャレ" }
    invitation { "一緒にお食事しませんか？" }
    plan { "オシャレなお店でお食事をしながら、会話を楽しむ。" }
    association :user
    created_at { Time.current }
  end
end
