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

  def like_tweet
    @tweet = Tweet.find(params[:id])
    like(@tweet)
  end

  def unlike_tweet
    @tweet = Tweet.find(params[:id])
    unlike(@tweet)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text)
  end
end
