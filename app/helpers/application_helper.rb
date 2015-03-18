module ApplicationHelper
  def brand_tag(user)
    [].tap do |ary|
      ary << "Basewise"
      ary << ": " if user
      ary << link_to(user_name(user), edit_user_path(user)) if user
    end.join("").html_safe
  end

  def user_name(user)
    return nil unless user
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def session_links(user)
    if user
      link_to "Log Out", logout_path, method: :delete
    else
      content_tag(:span, class: "session_links") do
        link_to("Sign Up", register_path) +
        " | " +
        link_to("Log In", signin_path)
      end
    end
  end
end
