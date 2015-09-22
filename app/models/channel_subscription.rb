class ChannelSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel, foreign_key: :channel_name, primary_key: :name
end
