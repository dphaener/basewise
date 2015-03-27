class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= begin
      user = User.find_by_id(session[:user_id])
      UserDecorator.new(user) if user
    end
  end

  def login_as(user)
    return nil unless user
    session[:user_id] = user.id
    @current_user = user
  end

  def logout_user
    session.delete(:user_id)
    @current_user = nil
  end

  def authenticate_user!
    return if current_user
    redirect_to signin_path
  end
end
