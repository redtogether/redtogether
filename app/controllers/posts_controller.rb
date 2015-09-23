class PostsController < ApplicationController
  def show
    slug = params[:slug].split("_", 2).first

    @post = Post.find_by(slug: slug)
    @channel = @post.channel
    @comment = Comment.new(post: @post)
  end

  def new
    @channel = Channel.find_by_name(params[:name])

    redirect_to channel_path(@channel), \
      flash: { alert: "Must be signed in to submit a post." } \
      unless current_user

    @post = Post.new(channel: @channel, user: current_user)
  end

  def create
    @channel = Channel.find_by_name(params[:name])
    @post = Post.new(post_params)

    @post.channel = @channel
    @post.user = current_user

    @post.save!

    redirect_to channel_path(@channel), flash: { notice: "Post created" }
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
