class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :reconfirmable

  has_many :posts
  has_many :comments
  has_many :channel_subscriptions

  def subscribe(channel)
    if subscribed?(channel)
      nil
    else
      ChannelSubscription.create!(user: self, channel: channel)
    end
  end

  def unsubscribe(channel)
    if subscribed?(channel)
      subscription = channel_subscriptions.where(channel: channel).first
      subscription.destroy! if subscription
    else
      nil
    end
  end

  def subscribed?(channel)
    channel_subscriptions
      .pluck(:channel_name)
      .map(&:downcase)
      .include?(channel.name.downcase)
  end
end
