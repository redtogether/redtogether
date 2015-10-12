class Channel < ActiveRecord::Base
  has_many :posts, foreign_key: :channel_name, primary_key: :name
  has_many :channel_subscriptions, foreign_key: :channel_name, primary_key: :name
  has_many :users, through: :channel_subscriptions

  alias_method :subscribers, :users

  RESERVED_NAMES = %w( all random )

  validates :name,
    uniqueness: {
      case_sensitive: false
    },
    length: {
      minimum: 3,
      maximum: 64
    },
    exclusion: {
      in: RESERVED_NAMES,
      case_sensitive: false,
      message: "is a reserved channel name"
    },
    format: {
      with: /\A\w+\z/,
      message: "can only contain letters, numbers and underscores"
    }

  def to_param
    "+#{name}"
  end

  def self.find_by_name(param)
    return nil if param.blank?

    name = param.split("+", 2)[1]

    if name
      channels = Channel.arel_table
      where(channels[:name].lower.eq(name.downcase)).first
    end
  end
end
