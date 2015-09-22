class CommentController < ApplicationController
  def create
    if !current_user
      flash[:alert] = "Must be logged in to post a comment"
      redirect_to @post
    end
    
    @post = Post.find_by_slug(params[:slug])
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
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
