class TweetsController < ApplicationController
  # ツイート作成フォーム
  def new
    @tweet = Tweet.new
  end

  # ツイート作成
  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.present?
      @tweet.save!
      redirect_to root_path, notice: 'ツイートを送信しました'
    else
      # ツイート作成に失敗した場合, 投稿内容をそのままにして保存失敗フラッシュを出す
      # ページ遷移はせずにviewをレンダーする
      @tweet = Tweet.new(tweet_params)
      render 'new', notice: 'ツイート送信に失敗しました'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end

end
