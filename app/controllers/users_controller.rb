class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @liked_posts = @user.likes.order('created_at DESC')
  end
end
