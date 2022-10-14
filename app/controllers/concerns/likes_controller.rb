module LikesController
  def like(likable_type)
    likable_type.liked_by(current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike(likable_type)
    likable_type.unliked_by(current_user)
    redirect_back(fallback_location: root_path)
  end
end
