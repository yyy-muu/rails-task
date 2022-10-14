class Relationship < ApplicationRecord
  # class_name モデル名と違う関連付け名を指定
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followed_id }
end
