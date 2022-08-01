class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :text, length: { maximum: 140 }
end
