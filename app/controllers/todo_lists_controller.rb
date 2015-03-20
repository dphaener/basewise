class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project

  def create
    @todo_list = @project.todo_lists.create(todo_list_params)
  end

  def show
    
  end

  def update
    
  end

  def destroy
    
  end

private

  def todo_list_params
    params.require(:todo_list).permit(:title, :description)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end