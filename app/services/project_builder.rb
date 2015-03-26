class ProjectBuilder
  include Transactable
  include Virtus.model

  # Project
  attribute :title, String
  attribute :description, String

  # Todo List
  attribute :todo_list_title, String, default: "Sample Todo List"
  attribute :todo_list_description, String, default: "New Todos"

  # Todo
  attribute :todo_title, String, default: "Sample Todo"
  attribute :todo_complete, Boolean, default: false

  validates :title, length: { minimum: 5 }

  attr_accessor :user, :project, :todo_list, :todo

  def initialize(user, params = {})
    @user = user
    @project = Project.new
    @todo_list = TodoList.new
    @todo = Todo.new
    super(params)
  end

  def project_params
    {
      title: title,
      description: description
    }
  end

  def todo_list_params
    {
      title: todo_list_title,
      description: todo_list_description
    }
  end

  def todo_params
    {
      title: todo_title,
      complete: todo_complete
    }
  end

  def save_project!
    project.attributes = project_params
    project.user = user
    project.save!
  end

  def save_todo_list!
    todo_list.attributes = todo_list_params
    todo_list.project = project
    todo_list.save!
  end

  def save_todo!
    todo.attributes = todo_params 
    todo.todo_list = todo_list
    todo.save!
  end

  def build
    return false unless valid?

    catch_errors do
      save_project!
      save_todo_list!
      save_todo!
    end
  end
end