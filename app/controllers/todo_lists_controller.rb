class TodoListsController < ApplicationController
  before_action :authenticate_user!

  def create
    
  end

  def show
    
  end

  def update
    
  end

  def destroy
    
  end

private

  def todo_list_params
    params.require(:todo_list).permit(:title, :description, :project_id)
  end
end