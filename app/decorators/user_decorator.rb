class UserDecorator < ApplicationDecorator
  def profile_link
    ": #{link_to(name, edit_user_path(user))}".html_safe
  end

  def name
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  alias_method :user, :model
end