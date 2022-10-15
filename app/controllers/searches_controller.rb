class SearchesController < ApplicationController
  def search_posts
    @target = params[:target] # 検索対象モデル

    if @target == 'ツイート'
      @tweets = Tweet.find_keywords(params[:keywords])
    elsif @target == 'コメント'
      @comments = Comment.find_keywords(params[:keywords])
    else
      @tweets = Tweet.find_keywords(params[:keywords])
      @comments = Comment.find_keywords(params[:keywords])
    end
  end
end
