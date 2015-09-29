class FrontPageController < ApplicationController
  include VoteableHelper
  
  def index
    if current_user
      @posts = current_user.subscribed_posts
    else
      @posts = Post.all
    end

    @posts = @posts
      .includes(:channel, :poster)
      .order(created_at: :desc)
      .take(15)

    get_upvoted_downvoted(current_user, @posts) if current_user

    @channels = Channel
      .order(created_at: :desc)
      .take(5)
  end

  def all
    @posts = Post.all
      .includes(:channel, :poster)
      .order(created_at: :desc)
      .take(15)
  end
end
