User.create!(name:  "例　太郎",
  email: "example@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  sex: 0,
  introduction: "はじめまして。",
  admin: true)

49.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@example.com"
password = "password"
sex = 1
introduction = "はじめまして。"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
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
following = users[2..40]
followers = users[3..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
