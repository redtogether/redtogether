class FrontPageController < ApplicationController
  def index
    @posts = Post.take(15)
  end
end
