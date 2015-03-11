class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:user])

    if @user
      login_as(@user)
      redirect_to projects_path
    else
      flash.now[:notice] = "Email or password is incorrect"
      @user = User.new
      render "new"
    end
  end

  def destroy
    if @current_user
      
    else
      redirect_to signin_path
    end
  end
end
