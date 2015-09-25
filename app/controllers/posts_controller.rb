class PostsController < ApplicationController
  def show
    @post = Post.find_by_param(params[:id])
    @channel = @post.channel
    @reply = Comment.new(post: @post)
    @comments = @post.top_level_comments.order(created_at: :desc)
  end

  def new
    @channel = Channel.find_by_name(params[:channel_id])

    redirect_to channel_path(@channel), \
      flash: { alert: "Must be signed in to submit a post." } \
      unless current_user

    @post = Post.new(channel: @channel, user: current_user)
  end

  def create
    @channel = Channel.find_by_name(params[:channel_id])
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
