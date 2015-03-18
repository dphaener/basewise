require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = Fabricate(:user)
  end

  context "GET /edit" do
    should "render the edit template and respond with a 200" do
      login_user(@user)

      get :edit, id: @user.id
      assert_response :success
      assert_template :edit
    end
  end

  context "PUT /user/:id" do
    context "when the params are valid" do
      setup do
        @valid_params = {
          id: @user.id,
          user: {
            first_name: "Michael",
            last_name: "Jackson",
            email: "michael@thriller.com",
            password: "foobar$68"
          }
        }
      end

      should "update the user, redirect to the edit page and flash a message" do
        put :update, @valid_params

        @user.reload

        assert_equal "Michael", @user.first_name
        assert_equal "Jackson", @user.last_name
        assert_equal "michael@thriller.com", @user.email
        assert_equal @user, User.authenticate(email: @user.email, password: "foobar$68")
        assert_redirected_to edit_user_path
        assert_equal "Your profile has been updated", flash[:success]
      end
    end

    context "when the params are invalid" do
      setup do
        @invalid_params = {
          id: @user.id,
          user: {
            first_name: "F"
          }
        }
      end

      should "render the edit form" do
        put :update, @invalid_params
        assert_template :edit
      end
    end
  end
end