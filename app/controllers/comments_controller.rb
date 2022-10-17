class CommentsController < ApplicationController

  include LikesController
  
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

  def like_comment
    @comment = Comment.find(params[:id])
    like(@comment, current_user)
  end

  def unlike_comment
    @comment = Comment.find(params[:id])
    unlike(@comment, current_user)
  end

  private

  def comment_params
    params.required(:comment).permit(:tweet_id, :text)
  end
end
