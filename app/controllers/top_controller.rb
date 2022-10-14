class TopController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @tweets = if user_signed_in?
                # 自分の投稿とフォローユーザの投稿を表示
                Tweet.where(user_id: [current_user.id, *current_user.following_ids]).order('created_at DESC')
              else
                Tweet.all.order('created_at DESC')
              end
  end
end
