class CreateChannelSubscriptions < ActiveRecord::Migration
  def change
    create_table :channel_subscriptions do |t|
      t.integer :user_id
      t.string :channel_name

      t.timestamps null: false
    end
  end
end
