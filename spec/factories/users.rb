FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'testuser@test.com' }
    password { 'testtest' }
  end
end
