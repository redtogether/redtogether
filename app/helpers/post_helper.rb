module PostHelper
  def post_upvote_button(post)
    button_to raw("&uparrow;"),
      post_upvote_path(post),
      method: :put,
      class: "vote-button upvote",
      rel: "upvote",
      "data-post-id" => post.slug
  end

  def post_downvote_button(post)
    button_to raw("&downarrow;"),
      post_downvote_path(post),
      method: :put,
      class: "vote-button downvote",
      rel: "downvote",
      "data-post-id" => post.slug
  end

  def post_unvote_button(post)
    button_to raw("&cir;"),
      post_unvote_path(post),
      method: :put,
      class: "vote-button unvote",
      rel: "unvote",
      "data-post-id" => post.slug
  end

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

  def post_unvote_path(post)
    channel_post_unvote_path \
      channel_id: post_channel_id(post),
      post_id: post
  end

protected

  def post_channel_id(post)
    "+#{post.channel_name}"
  end

end
