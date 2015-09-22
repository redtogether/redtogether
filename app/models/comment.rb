class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: :User, foreign_key: :user_id
	
  has_many :children, class_name: :Comment, foreign_key: :parent_id
  belongs_to :parent, class_name: :Comment

  before_create do |post|
    post.slug = RandomIdHelper.random_id
  end

  scope :top_level, -> { where(parent_id: nil) }

  def to_param
    slug
  end
end
