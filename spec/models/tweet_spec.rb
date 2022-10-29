require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:user) { FactoryBot.create(:user, email: 'testuser2@test.com') }
  let(:tweet) { FactoryBot.build(:tweet, user_id: user.id) }

  describe 'positive' do
    # ツイートを作成できる(ユーザと紐づき、140文字以内のツイート文が存在する)
    it 'can create tweet include 140 or less text which belongs to user' do
      expect(tweet).to be_valid
    end

    describe 'positive for likable' do
      before do
        tweet.save
      end

      # ツイートはユーザにいいねされる
      it 'is likable by user' do
        tweet.liked_by(user)
        expect(tweet.likes.where(user: user).present?).to be_truthy
      end

      # ツイートはユーザにいいね解除される
      it 'is unlikable by user' do
        tweet.liked_by(user)
        tweet.unliked_by(user)
        expect(tweet.likes.where(user: user).present?).to be_falsey
      end
    end
  end

  describe 'negative' do
    # ツイートがユーザと紐づいていない場合、無効になる
    it 'is invalid without user' do
      tweet = FactoryBot.build(:tweet, user_id: nil)
      expect(tweet).to be_invalid
    end

    # ツイート文が空の場合、ツイートを作成できない
    it 'cannot create tweet without text' do
      tweet.update(text: nil)
      expect(tweet).to be_invalid
    end

    # ツイート文が141文字以上の場合、ツイートを作成できない
    it 'cannot create tweet with text more or 141' do
      tweet.update(
        text: 'この文章はダミーです。141文字あります。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、'
      )
      expect(tweet).to be_invalid
    end
  end
end
