class PostsController < ApplicationController
  include PostHelper
  include VoteableHelper

  def show
    @post = Post.find_by_param(params[:id])
    @channel = @post.channel
    @reply = Comment.new(post: @post)
    @comments = @post.top_level_comments.order(created_at: :desc)

    get_upvoted_downvoted(current_user, @post)
    get_upvoted_downvoted(current_user, @comments)
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
    vote :upvote
  end

  def downvote
    vote :downvote
  end

  def unvote
    vote :unvote
  end

protected

  def vote(action)
    @post = Post.find_by_param(params[:post_id])

    if current_user
      current_user.send(action, @post)
    else
      flash[:alert] = "Must be signed in to vote"
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { links: post_links(@post) } }
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def post_links(post)
    {
      upvote: url_for(post_upvote_path(@post)),
      downvote: url_for(post_downvote_path(@post)),
      unvote: url_for(post_unvote_path(@post))
    }
  end
end
