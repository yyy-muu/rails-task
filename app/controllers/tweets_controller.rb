class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: 'ツイートを送信しました'
    else
      flash.now[:alert] = 'ツイートの送信に失敗しました'
      render 'new'
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comments = @tweet.comments.order('created_at DESC')
  end

  def like(_tweet)
    @tweet = Tweet.find(params[:id])
    # いいね済の場合、いいね解除する
    if @tweet.liked_by?(current_user)
      @tweet.unliked_by(current_user)
      redirect_to request.referer
    else # 未いいねの場合、いいねする
      @tweet.liked_by(current_user)
      redirect_to request.referer
    end
  end

  def like_tweet
    like(@tweet)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text)
  end
end
