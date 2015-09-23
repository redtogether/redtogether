class CommentsController < ApplicationController
  def create
    if !current_user
      flash[:alert] = "Must be logged in to post a comment"
      redirect_to @post
    end
    
    @post = Post.find_by(slug: params[:slug])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.author = current_user
    
    if @comment.save
      flash[:notice] = "Posted comment"
    else
      flash[:alert] = "Failed to post comment"
    end
    
    redirect_to @post
  end

  def show
    @comment = Comment.find_by(slug: params[:slug])
    @post = @comment.post
    @reply = Comment.new
  end

  def reply
    @parent = Comment.find_by(slug: params[:slug])
    @post = @parent.post

    @reply = Comment.new(comment_params)
    @reply.post = @post
    @reply.author = current_user
    @reply.parent = @parent

    if @reply.save
      flash[:notice] = "Posted reply"
    else
      flash[:alert] = "Failed to post reply"
    end
    
    redirect_to @parent
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
