class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :body
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
