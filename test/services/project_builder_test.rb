require 'test_helper'

class ProjectBuilderTest < ActiveSupport::TestCase
  context "#build" do
    setup do
      @user = Fabricate(:user)
    end

    context "when invalid attributes are given" do
      setup do
        @params = {
          title: "Pr",
          description: "Foo"
        }

        @builder = ProjectBuilder.new(@user, @params)
      end

      should "not create any objects and return the errors" do
        @builder.build

        assert_equal 0, Project.count
        assert_equal 0, TodoList.count
        assert_equal 0, Todo.count
        assert @builder.errors.any?
      end
    end

    context "when valid attributes are given" do
      setup do
        @params = {
          title: "Project of Doom",
          description: "Foo"
        }

        @builder = ProjectBuilder.new(@user, @params)
      end

      should "create all the objects" do
        @builder.build

        project = Project.last

        assert_equal "Project of Doom", project.title
        assert_equal "Foo", project.description
        assert_equal 1, TodoList.count
        assert_equal 1, Todo.count
      end
    end
  end
end