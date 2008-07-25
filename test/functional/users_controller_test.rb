require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < Test::Unit::TestCase

  fixtures :users

  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = User.first
  end
  
  context 'with admin' do
    setup {login_as(:aaron)}

    should_be_restful do |resource|
      resource.formats = [:html]
      resource.create.params = { :email => 'bob@bob.com', :password => 'test123', :password_confirmation => 'test123'}
      resource.actions    = [:index, :new, :edit, :update, :create, :destroy]
      resource.create.redirect  = "users_path"
      resource.update.redirect  = "users_path"
    end

    def test_should_allow_signup
      assert_difference 'User.count' do
        create_user
        assert_response :redirect
      end
    end

    def test_should_require_password_on_signup
      assert_no_difference 'User.count' do
        create_user(:password => nil)
        assert assigns(:user).errors.on(:password)
        assert_response :success
      end
    end

    def test_should_require_password_confirmation_on_signup
      assert_no_difference 'User.count' do
        create_user(:password_confirmation => nil)
        assert assigns(:user).errors.on(:password_confirmation)
        assert_response :success
      end
    end

    def test_should_require_email_on_signup
      assert_no_difference 'User.count' do
        create_user(:email => nil)
        assert assigns(:user).errors.on(:email)
        assert_response :success
      end
    end

    should 'show edit page on update error' do
      put :update, :user => { :email => 'aaron@example.com'}, :id => users(:quentin).id
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end
  
  context 'without admin' do
    setup {login_as(:quentin)}

    should_be_restful do |resource|
      resource.formats = [:html]
      resource.create.params = { :email => 'bob@bob.com', :password => 'test123', :password_confirmation => 'test123'}
      resource.denied.actions = [:index, :new, :edit, :update, :create, :destroy]
      resource.actions = []
      resource.denied.redirect  = "albums_path"
    end
  end

  protected
    def create_user(options = {})
      post :create, :user => { :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
