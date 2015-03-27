module ApplicationHelper


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
