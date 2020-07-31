User.create!(name:  "例　太郎",
  email: "example@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@example.com"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

10.times do |n|
  Datespot.create!(name: Faker::Restaurant.name,
                  area: "恵比寿",
                  price: "1万円〜",
                  keyword: "焼き鳥",
                  user_id: 1)
end
