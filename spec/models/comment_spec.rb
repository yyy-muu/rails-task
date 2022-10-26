require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:tweet) { FactoryBot.create(:tweet) }
  let(:comment) { FactoryBot.build(:comment, user_id: user.id, tweet_id: tweet.id) }

  describe 'positive' do
    # コメントを作成できる(ツイート/ユーザと紐づき、140文字以内のコメント文が存在する)
    it 'can create comment include 140 or less text which belongs to user and tweet' do
      expect(comment).to be_valid
    end

    describe 'positive for likable' do
      before do
        comment.save
      end

      # コメントはユーザにいいねされる
      it 'is likable by user' do
        comment.liked_by(user)
        expect(comment.likes.where(user: user).present?).to be_truthy
      end

      # コメントはユーザにいいね解除される
      it 'is unlikable by user' do
        comment.liked_by(user)
        comment.unliked_by(user)
        expect(comment.likes.where(user: user).present?).to be_falsey
      end
    end
  end

  describe 'negative' do
    # コメントがユーザと紐づいていない場合、無効になる
    it 'is invalid without user' do
      comment = FactoryBot.build(:comment, user_id: nil)
      expect(comment).to be_invalid
    end

    # コメントがツイートと紐づいていない場合、無効になる
    it 'is invalid without user' do
      comment = FactoryBot.build(:comment, tweet_id: nil)
      expect(comment).to be_invalid
    end

    # コメント文が空の場合、コメントを作成できない
    it 'cannot create comment without text' do
      comment.update(text: nil)
      expect(comment).to be_invalid
    end

    # コメント文が141文字以上の場合、コメントを作成できない
    it 'cannot create comment with text more or 141' do
      comment.update(
        text: 'この文章はダミーです。141文字あります。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、'
      )
      expect(comment).to be_invalid
    end
  end
end
