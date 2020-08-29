User.create!(name:  "例　太郎",
  email: "example@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  introduction: "はじめまして。",
  admin: true)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@example.com"
password = "password"
introduction = "はじめまして。"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    introduction: introduction)
end

10.times do |n|
  Datespot.create!(name: Faker::Restaurant.name,
                  place: 0,
                  range: 0,
                  keyword: "焼き鳥",
                  user_id: 1)
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
