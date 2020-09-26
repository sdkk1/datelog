FactoryBot.define do
  factory :datespot do
    name { Faker::Restaurant.name }
    address { "東京都渋谷区恵比寿西" }
    range { 0 }
    tag_list { "オシャレ" }
    point { "シックな店内で落ち着いた雰囲気のお店" }
    caution { "お酒の種類は少ない" }
    association :user
    created_at { Time.current }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end
end
