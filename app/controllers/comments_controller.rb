class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comment = Comment.all.order('created_at DESC')
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comments_path, notice: 'コメントを送信しました'
    else
      flash.now[:alert] = 'コメントの送信に失敗しました'
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
