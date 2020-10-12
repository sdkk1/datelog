FactoryBot.define do
  factory :datespot do
    name { Faker::Restaurant.name }
    address { "東京都渋谷区恵比寿西" }
    prefecture_code { 13 }
    range { 0 }
    tag_list { "オシャレ" }
    point { "シックな店内で落ち着いた雰囲気のお店" }
    caution { "お酒の種類は少ない" }
    association :user
    created_at { Time.current }
  end
end
