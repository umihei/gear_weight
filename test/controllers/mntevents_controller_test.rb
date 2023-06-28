require "test_helper"
require 'rails-controller-testing'

class MnteventsControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers
  
  def setup
    @user = users(:example_user)
    
    sign_in @user
    
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_mntevents)
  end
  
  test "should get show" do
    get :show, params: {id: @mntevent.id}
    assert_response :success
    assert_not_nil assigns(:mntevent)
    assert_not_nil assigns(:gears)
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:mntevent)
    assert_instance_of Mntevent, assigns(:mntevent)
  end
  
  test "should create mntevent" do
    assert_difference('Mntevent.count') do
      post :create, params: { mntevent: {eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id} }
    end
    
    assert_redirected_to mntevent_path(assigns(:mntevent))
  end
  
  test "should get edit" do
    get :edit, params: {id: @mntevent.id}
    assert_response :success
    assert_not_nil assigns(:mntevent)
  end
  
  test "should update mntevent" do
    patch :update, params: {id: @mntevent.id, mntevent: { eventname: 'update' } }
    assert_redirected_to assigns(:mntevent)
    @mntevent.reload
    assert_equal "update", @mntevent.eventname
  end
  
  test "should delete mntevent" do
    assert_difference('Mntevent.count', -1) do
      delete :destroy, params: {id: @mntevent.id}
    end
    assert_redirected_to mntevents_path
  end
end

# class MnteventsControllerTest < ActionDispatch::IntegrationTest
#   # test "the truth" do
#   #   assert true
#   # end
#   end
# end
