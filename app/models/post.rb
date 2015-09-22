class Post < ActiveRecord::Base
  belongs_to :channel, foreign_key: :channel_name, primary_key: :name
  belongs_to :user
  
  has_many :comments

  before_create do |post|
    post.slug = RandomIdHelper.random_id
  end

  def to_param
    slug
  end

  def normalized_title
    title.gsub(/[^0-9A-Za-z]+/, "_").downcase[0...64]
  end

  def domain
    begin
      host = URI.parse(body).host.downcase
      host.start_with?("www.") ? host[4..-1] : host
    rescue
      nil
    end
  end
end
