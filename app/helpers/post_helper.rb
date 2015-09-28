module PostHelper
  def post_path(post)
    channel_post_path \
      channel_id: post_channel_id(post),
      id: post
  end

  def post_comments_path(post)
    channel_post_comments_path \
      channel_id: post_channel_id(post),
      post_id: post
  end

  def post_upvote_path(post)
    channel_post_upvote_path \
      channel_id: post_channel_id(post),
      post_id: post
  end

  def post_downvote_path(post)
    channel_post_downvote_path \
      channel_id: post_channel_id(post),
      post_id: post
  end

protected

  def post_channel_id(post)
    "+#{post.channel_name}"
  end

end
