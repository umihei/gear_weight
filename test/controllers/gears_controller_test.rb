require "test_helper"
require 'rails-controller-testing'

class GearsControllerTest < ActionController::TestCase
  
  include Devise::Test::ControllerHelpers
  
  def setup
    @user = users(:example_user)
    sign_in @user
    
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    @gear = Gear.create(name: "gearname", weight: 80, mntevents_id: @mntevent.id, user_id: @user.id)
    @mntevent.gears << @gear
  end

  test "should get index" do
    # log_in_as(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:user_gears)
  end

  # test "should get show" do
  #   # log_in_as(@user)
  #   get :show, params: { id: @gear.id }
  #   assert_response :success
  # end

  test "should get new" do
    # log_in_as(@user)
    get :new, params: { mntevents_id: @mntevent.id }
    assert_response :success
    assert_not_nil assigns(:gear)
    
    assert_instance_of Gear, assigns(:gear)
    # assert_equal @mntevent.id, assigns(:mntevents_id)
  end

  test "should create gear" do
    # log_in_as(@user)
    assert_difference('Gear.count', 1) do
      post :create, params: { gear: { name: "Example Gear", weight: 10, mntevents_id: @mntevent.id, user_id: @user.id } }
    end
    assert_redirected_to new_gear_path(mntevents_id: @mntevent.id)
  end

  test "should get edit" do
    # log_in_as(@user)
    get :edit, params: { id: @gear.id }
    assert_response :success
    assert_not_nil assigns(:gear)
    assert_equal @gear.mntevents_id, assigns(:mntevents_id)
  end

  test "should update gear" do
    # log_in_as(@user)
    patch :update, params: { id: @gear.id, gear: { weight: 15 } }
    assert_redirected_to mntevent_path(@gear.mntevents_id)
    @gear.reload
    assert_equal 15, @gear.weight
  end

  test "should destroy gear" do
    # log_in_as(@user)
    assert_difference('Gear.count', -1) do
      delete :destroy, params: { id: @gear.id }
    end
    assert_redirected_to gears_path
  end
end