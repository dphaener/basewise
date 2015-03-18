class UsersController < ApplicationController
  before_action :load_user

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated"
      redirect_to edit_user_path(@user)
    else
      render "edit"
    end
  end

  def destroy

  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end