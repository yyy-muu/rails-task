FactoryBot.define do
  factory :comment do
    text { '初めてのコメント' }
    association :user
    association :tweet
  end
end
