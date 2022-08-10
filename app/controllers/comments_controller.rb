class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to tweet_path(params[:tweet_id]), notice: 'コメントを送信しました'
    else
      flash.now[:alert] = 'コメントの送信に失敗しました'
      render 'new'
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:tweet_id, :text)
  end
end
