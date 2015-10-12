class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: :User, foreign_key: :user_id
	
  has_many :children, class_name: :Comment, foreign_key: :parent_id
  belongs_to :parent, class_name: :Comment

  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable

  attr_accessor :upvoted, :downvoted

  def compute_score
    upvotes_count - downvotes_count
  end

  before_create do |post|
    post.slug = RandomIdHelper.random_id
  end

  scope :top_level, -> { where(parent_id: nil) }

  def to_param
    slug
  end

  def self.find_by_param(param)
    find_by(slug: param)
  end
end
