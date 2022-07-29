class TopController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def show
  end
end
