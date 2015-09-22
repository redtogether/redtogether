class Channel < ActiveRecord::Base
  has_many :posts, foreign_key: :channel_name, primary_key: :name
  has_many :channel_subscriptions, foreign_key: :channel_name, primary_key: :name

  validates :name, uniqueness: { case_sensitive: false }

  def to_param
    name
  end

  def self.find_by_name(name)
    where("lower(name) = ?", name.downcase).first
  end

  def subscribers
    channel_subscriptions.includes(:user).map(&:user)
  end
end
