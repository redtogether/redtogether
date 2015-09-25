module UserHelper
  def user_link(user)
    link_to "@#{user.handle}", user_path(user)
  end
end
