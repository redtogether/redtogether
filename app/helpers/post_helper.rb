module PostHelper
  def post_path(post)
    channel_post_path channel_id: "+#{post.channel_name}", id: post.to_param
  end

  def post_comments_path(post)
    channel_post_comments_path channel_id: "+#{post.channel_name}", post_id: post.to_param
  end
end
