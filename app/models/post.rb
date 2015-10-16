class Post < ActiveRecord::Base
  belongs_to :channel, foreign_key: :channel_name, primary_key: :name
  belongs_to :poster, class_name: :User, foreign_key: :user_id
  
  has_many :comments

  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable

  attr_accessor :upvoted, :downvoted

  before_create do |post|
    post.slug = RandomIdHelper.random_id
  end

  def score
    upvotes_count - downvotes_count
  end

  def to_param
    [slug, normalized_title].join("-")
  end

  def normalized_title
    title.downcase.gsub(/\W+/, "-").sub(/-\Z/, "")[0...64]
  end

  def self.find_by_param(param)
    return nil unless param
    slug = param.split("-", 2).first
    find_by(slug: slug)
  end

  def domain
    begin
      host = URI.parse(body).host.downcase
      host.start_with?("www.") ? host[4..-1] : host
    rescue
      nil
    end
  end

  def top_level_comments
    comments.top_level
  end

  FRONTPAGE_SQL = <<-EOF.tr("\n", "").freeze
    (upvotes_count - downvotes_count - 1) /
    ((EXTRACT(EPOCH FROM NOW() - created_at) / 3600) + 2) ^ %f
    AS frontpage_score
  EOF

  scope :with_frontpage_score, -> {
    all.select(ActiveRecord::Base.send(:sanitize_sql_array,
      [FRONTPAGE_SQL, Rails.configuration.x.gravity]), "*")
  }
end
