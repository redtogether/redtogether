class Downvote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true, counter_cache: true
  belongs_to :user
end
