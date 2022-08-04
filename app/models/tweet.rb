class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :text, presence: true, length: { maximum: 140 }
end
