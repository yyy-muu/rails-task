FactoryBot.define do
  factory :tweet do
    text { '初めてのツイート' }
    association :user
  end
end
