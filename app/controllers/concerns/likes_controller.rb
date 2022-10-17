module LikesController
  def like(likable_type, user)
    likable_type.liked_by(user)
    redirect_back(fallback_location: root_path)
  end

  def unlike(likable_type, user)
    likable_type.unliked_by(user)
    redirect_back(fallback_location: root_path)
  end
end
