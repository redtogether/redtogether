class CommentsController < ApplicationController
  def create
    @post = Post.find_by_param(params[:post_id])

    if !current_user
      flash[:alert] = "Must be logged in to post a comment"
    else
      @comment = Comment.new(comment_params)
      @comment.post = @post
      @comment.author = current_user
      
      if @comment.save
        flash[:notice] = "Posted comment"
      else
        flash[:alert] = "Failed to post comment"
      end
    end
    
    redirect_to \
      channel_post_path channel_id: "+#{@post.channel_name}", id: @post.to_param
  end

  def show
    @comment = Comment.find_by(slug: params[:id])
    @post = Post.find_by_param(params[:post_id])

    render status: 401, body: "Comment and post mismatch" \
      unless @comment.post == @post

    @reply = Comment.new
  end

  def reply
    @parent = Comment.includes(:post).find_by(slug: params[:comment_id])
    @post = Post.find_by_param(params[:post_id])

    render status: 401, body: "Comment and post mismatch" \
      unless @parent.post == @post

    @reply = Comment.new(comment_params)
    @reply.post = @post
    @reply.author = current_user
    @reply.parent = @parent

    if @reply.save
      flash[:notice] = "Posted reply"
    else
      flash[:alert] = "Failed to post reply"
    end
    
    redirect_to \
      channel_post_comment_path({
        id: @parent,
        post_id: @post,
        channel_id: "+#{@post.channel_name}"
      })
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
