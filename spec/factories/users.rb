# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    nickname { "テストユーザー" }
    email { Faker::Internet.unique.email }
    password { "password1" }
    password_confirmation { password }
  end
end
