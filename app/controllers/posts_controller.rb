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

    @post = Post.new(channel: @channel, poster: current_user)
  end

  def create
    @channel = Channel.find_by_name(params[:channel_id])
    @post = Post.new(post_params)

    @post.channel = @channel
    @post.poster = current_user

    @post.save!

    redirect_to channel_path(@channel), flash: { notice: "Post created" }
  end

  def upvote
    @post = Post.find_by_param(params[:post_id])

    if current_user
      current_user.upvote(@post)
    else
      flash[:alert] = "Must be signed in to vote"
    end

    redirect_to :back
  end

  def downvote
    @post = Post.find_by_param(params[:post_id])

    if current_user
      current_user.downvote(@post)
    else
      flash[:alert] = "Must be signed in to vote"
    end

    redirect_to :back
  end

  def unvote
    @post = Post.find_by_param(params[:post_id])

    if current_user
      current_user.unvote(@post)
    else
      flash[:alert] = "Must be signed in to vote"
    end

    redirect_to :back
  end

protected

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
