User.create!(name:  "例　太郎",
  email: "example@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 28,
  prefecture_code: 13,
  sex: 0,
  introduction: "よろしくお願いします！",
  admin: true)

39.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@example.com"
password = "password"
age = 25
prefecture_code = 14
sex = 1
introduction = "はじめまして。"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    age: age,
    prefecture_code: prefecture_code,
    sex: sex,
    introduction: introduction)
end

5.times do |n|
  Datespot.create!(name: Faker::Restaurant.name,
                  address: "東京都渋谷区恵比寿西",
                  range: 0,
                  tag_list: "美味しい, オシャレ",
                  point: "シックな店内で落ち着いた雰囲気のお店",
                  caution: "お酒の種類は少ない",
                  user_id: 1)
end

5.times do |n|
  Datespot.create!(name: Faker::Restaurant.name,
                  address: "東京都渋谷区恵比寿南",
                  range: 1,
                  tag_list: "美味しい, 安い",
                  point: "料理が安くて、美味しい",
                  caution: "店内は少し古い",
                  user_id: 2)
end

users = User.all
user  = users.first
following = users[2..30]
followers = users[3..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
