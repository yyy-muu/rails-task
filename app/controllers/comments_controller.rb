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

  def like(_comment)
    @comment = Comment.find(params[:id])
    # いいね済の場合、いいね解除する
    if @comment.liked_by?(current_user)
      @comment.unliked_by(current_user)
      redirect_to request.referer
    else # 未いいねの場合、いいねする
      @comment.liked_by(current_user)
      redirect_to request.referer
    end
  end

  def like_comment
    like(@comment)
  end

  private

  def comment_params
    params.required(:comment).permit(:tweet_id, :text)
  end
end
