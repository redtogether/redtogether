class AddDefaultToPostCommentCount < ActiveRecord::Migration
  def change
    change_column_default :posts, :comments_count, 0
  end
end
