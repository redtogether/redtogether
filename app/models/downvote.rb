class Downvote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true, counter_cache: true
  belongs_to :user

  after_save :update_voteable_score
  after_destroy :update_voteable_score

protected

  def update_voteable_score
    voteable.update(score: voteable.compute_score)
  end
end
