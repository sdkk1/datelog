FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    introduction { "はじめまして。" }
    sex { 1 }

    trait :picture do
      picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_user.jpg')) }
    end

    trait :admin do
      admin { true }
    end
  end
end
