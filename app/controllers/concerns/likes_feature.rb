module LikeFeature

  # typeには、ポリモーフィックで関連付けされたモデル名が入る(tweet or comment)
  def like(likable_type)
    # いいね済の場合、いいね解除する
    if likable_type.liked_by?(current_user)
      likable_type.unliked_by(current_user)
      # redirect_to request.referer, success: "いいねを取り消しました"
    # 未いいねの場合、いいねする
    else
      likable_type.liked_by(current_user)
      # redirect_to request.referer, success: "いいねしました"
    end
  end
end
