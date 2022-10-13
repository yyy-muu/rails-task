class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search_posts
    @target = params[:target] #検索対象モデル

    if @target == 'Tweet'
      @tweets = Tweet.find_keywords(params[:keywords])
    else
      @target == 'Comment'
      @comments = Comment.find_keywords(params[:keywords])
    end
  end
end
