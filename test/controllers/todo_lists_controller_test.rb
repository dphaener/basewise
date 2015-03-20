require 'test_helper'

class TodoListsControllerTest < ActionController::TestCase
  setup do
    @user = Fabricate(:user)
    @project = Fabricate(:project, user: @user)
  end

  context "POST /todo_lists" do
    setup do
      login_user(@user)
    end

    context "when the todo list creation is successful" do
      setup do
        @valid_attrs = {
          project_id: @project.id,
          todo_list: {
            title: "Foobar"
          },
          format: :json
        }
      end

      should "create a new todo list" do
        assert_difference("TodoList.count") do
          post :create, @valid_attrs
        end
      end
    end

    context "when the todo list creation fails" do
      setup do
        @invalid_attrs = {
          project_id: @project.id,
          todo_list: {
            description: "foo"
          },
          format: :json
        }
      end

      should "not create a new todo list" do
        assert_no_difference("TodoList.count") do
          post :create, @invalid_attrs
        end
      end
    end
  end
end