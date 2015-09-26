class AddIndexesToExistingTables < ActiveRecord::Migration
  def change
    add_index :channel_subscriptions, :user_id
    add_index :channels, expression: "LOWER(name)", name: "index_channels_on_lower_name", unique: true
    add_index :comments, :user_id
    add_index :comments, :post_id
    add_index :comments, :parent_id
    add_index :comments, :slug
    add_index :posts, :slug
    add_index :posts, :user_id
  end
end
