module VoteableHelper
  def get_upvoted_downvoted(user, voteables)
    # The order of these queries is not important
    #db_query_threads = [Thread.new {

      @up_groups = Upvote
        .where(voteable: voteables, user: user)
        .group(:voteable_id)
        .count

    #  }, Thread.new {

      @down_groups = Downvote
        .where(voteable: voteables, user: user)
        .group(:voteable_id)
        .count

    #}]
    #ThreadsWait.all_waits(*db_query_threads)

    voteables.each do |voteable|
      voteable.upvoted = @up_groups[voteable.id]
      voteable.downvoted = @down_groups[voteable.id]
    end
  end
end