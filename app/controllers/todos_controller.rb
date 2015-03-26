class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :load_todo_list

  def create
    @todo = @todo_list.todos.create(todo_params)
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(todo_params)
  end

  def destroy

  end

private

  def load_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_params
    params.require(:todo).permit(:title, :complete)
  end
end