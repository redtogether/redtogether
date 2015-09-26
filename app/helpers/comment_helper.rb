module CommentHelper
  def comment_path(comment)
    channel_post_comment_path({
      id: comment,
      post_id: comment.post,
      channel_id: "+#{comment.post.channel_name}"
    })
  end

  def comment_reply_path(comment)
    channel_post_comment_reply_path({
      comment_id: comment,
      post_id: comment.post,
      channel_id: "+#{comment.post.channel_name}"
    })
  end
end
