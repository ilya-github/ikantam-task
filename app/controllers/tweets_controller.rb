class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :destroy]
  before_action :require_login

  def index
    @tweet = Tweet.new
    @tweets = Tweet.where(user_id: session[:user_id].to_s)
    @tweets = @tweets.order('created_at DESC')
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    begin
      if @tweet.save
        redirect_to @tweet, success: 'Tweet successfully created'
      else
        redirect_to @tweet, danger: 'An error occurred creating the tweet'
      end
    rescue
      redirect_to @tweet, danger: 'Error loading image'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to @tweet, success: 'Tweet successfully deleted'
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:user_id, :body, :image, :twitter_url)
  end
end
