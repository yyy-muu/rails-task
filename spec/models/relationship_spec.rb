require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe 'following' do
    # ユーザが他のユーザをフォローできる
    it 'can follow by other user' do
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
    end

    # ユーザが他のユーザをフォロー解除できる
    it 'can unfollow by other user' do
      user.follow(other_user)
      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end
end
