class FrontPageController < ApplicationController
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
