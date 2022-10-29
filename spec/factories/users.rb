FactoryBot.define do
  factory :user do
    name { 'Test User' }
    # メールアドレスの重複を避けてユーザ作成する
    sequence(:email) { |n| "testuser#{n}@test.com" }
    password { 'testtest' }
  end
end
