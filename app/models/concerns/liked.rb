module Liked
  # いいね関連共通メソッド
  def liked_by(user)
    likes.where(user: user).first_or_create
  end

  def unliked_by(user)
    # いいね済(いいねを検索して1つ目に存在すれば、削除する)
    like = likes.where(user: user).first
    like.destroy if like.present?
  end

  def liked_count
    likes.count
  end

  # 該当ユーザにいいねされたかどうか
  def liked_by?(user)
    likes.where(user: user).present?
  end
end
