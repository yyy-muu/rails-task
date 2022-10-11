class UsersController < ApplicationController
  # ログインユーザのみユーザ詳細ページを見られる
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @liked_posts = @user.likes.order('created_at DESC')
  end
end
