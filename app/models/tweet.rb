class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  include Liked

  validates :text, presence: true, length: { maximum: 140 }

  def self.find_keywords(keywords)
    @tweet = Tweet.where("text LIKE?", "%#{keywords}%")
  end
end
