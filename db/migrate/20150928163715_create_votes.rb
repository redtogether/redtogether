class CreateVotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :user_id, index: true
      t.references :voteable, polymorphic: true, index: true
      t.timestamps null: false
    end

    create_table :downvotes do |t|
      t.integer :user_id, index: true
      t.references :voteable, polymorphic: true, index: true
      t.timestamps null: false
    end

    change_table :posts do |t|
      t.integer :upvotes_count, default: 0
      t.integer :downvotes_count, default: 0
      t.integer :score, default: 0
    end

    change_table :comments do |t|
      t.integer :upvotes_count, default: 0
      t.integer :downvotes_count, default: 0
      t.integer :score, default: 0
    end
  end
end
