class AddDefaultToPostCommentCount < ActiveRecord::Migration
  def change
    change_column_default :posts, :comments_count, 0

    Post.where(comments_count: nil).update_all(comments_count: 0)
  end
end
