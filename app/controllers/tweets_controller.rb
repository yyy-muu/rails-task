class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save!
      redirect_to root_path, notice: 'ツイートを送信しました'
    else
      render 'new'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text)
  end
end
