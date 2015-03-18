require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @user = Fabricate(:user)
  end

  context "GET /projects/index" do
    setup do
      @project = Fabricate(:project, user: @user)
      login_user(@user)

      get :index
    end

    should respond_with(200)
    should render_template(:index)
    should "assign to projects" do
      assert_equal [@project], assigns(:projects)
    end
  end

  context "GET /projects/new" do
    setup do
      login_user(@user)
      get :new
    end

    should respond_with(200)
    should render_template(:new)

    should "assign to project" do
      assert_not_nil assigns(:project)
    end
  end

  context "POST /projects" do
    setup do
      login_user(@user)
    end

    context "with valid params" do
      setup do
        @valid_params = {
          project: {
            title: "Valid title",
            description: "Description"
          }
        }
      end

      should "create a new project and redirect to the project page" do
        assert_difference("Project.count") do
          post :create, @valid_params
        end

        project = Project.last

        assert_redirected_to project_path(project)
      end
    end

    context "with invalid params" do
      setup do
        @invalid_params = {
          project: {
            title: "foo",
            description: "Description"
          }
        }
      end

      should "not create a new project and render the new template" do
        assert_no_difference("Project.count") do
          post :create, @invalid_params
        end

        assert_template :new
      end
    end
  end

  context "GET /project/:id" do
    setup do
      login_user(@user)
      @project = Fabricate(:project, user: @user)

      get :show, id: @project.id
    end

    should "load the project and render the show template" do
      assert_equal @project, assigns(:project)
      assert_template :show
      assert_response :success
    end
  end
end