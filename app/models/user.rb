class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :posts
  has_many :comments
  has_many :channel_subscriptions

  def to_param
    "@#{handle}"
  end

  def self.find_by_param(param)
    return nil if param.blank?

    handle = param.split("@", 2)[1]

    find_by(handle: handle) if handle
  end

  def upvote(voteable)
    existing_upvotes = Upvote.where(user: self, voteable: voteable)
    existing_downvotes = Downvote.where(user: self, voteable: voteable)

    existing_downvotes.destroy_all

    case existing_upvotes.count
    when 0 then Upvote.create(user: self, voteable: voteable)
    when 1 then true
    else
      existing_upvotes.take(existing_upvotes.count - 1).destroy_all
    end
  end

  def downvote(voteable)
    existing_upvotes = Upvote.where(user: self, voteable: voteable)
    existing_downvotes = Downvote.where(user: self, voteable: voteable)

    existing_upvotes.destroy_all

    case existing_downvotes.count
    when 0 then Downvote.create(user: self, voteable: voteable)
    when 1 then true
    else
      existing_downvotes.take(existing_downvotes.count - 1).destroy_all
    end
  end

  def unvote(voteable)
    Upvote.where(user: self, voteable: voteable).destroy_all && \
    Downvote.where(user: self, voteable: voteable).destroy_all
  end

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
    subscription_names.include?(channel.name.downcase)
  end

  def subscription_names
    channel_subscriptions.pluck(:channel_name).map(&:downcase)
  end

  def subscriptions
    channels = Channel.arel_table

    Channel.where(channels[:name].lower.in(arel_subscription_names))
  end

  def subscribed_posts
    posts = Post.arel_table

    Post.where(posts[:channel_name].lower.in(arel_subscription_names))
  end

  private

  def arel_subscription_names
    cs = ChannelSubscription.arel_table

    cs.project(cs[:channel_name].lower).where(cs[:user_id].eq(id))
  end
end
