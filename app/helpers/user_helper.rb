module UserHelper
  def user_link(user)
    link_to "@#{user.handle}", user
  end
end
