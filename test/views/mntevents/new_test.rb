require 'test_helper'
require 'rails-controller-testing'

class MnteventsNewViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
   include Devise::Test::IntegrationHelpers

  def setup
    
    @user = users(:example_user)
    
    # @mntevent1 = Mntevent.create(eventname:"testevent1", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    # @mntevent2 = Mntevent.create(eventname:"testevent2", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    
    # @mntevent1 = mntevents(:mntevent1)
    # @mntevent2 = mntevents(:mntevent2)
    sign_in @user
  end

  test "should display new mountain event form" do
    get new_mntevent_path

    assert_response :success
    assert_select 'h1', text: '新しい山行の登録'
    assert_select 'form[action=?][method=?]', mntevents_path, 'post' do
      assert_select 'div', count: 4
      assert_select 'label', text: '山行の名前'
      assert_select 'input[type=text][name=?]', 'mntevent[eventname]'
      assert_select 'label', text: '山に行った日'
      assert_select 'input[type=date][name=?]', 'mntevent[eventdate]'
      assert_select 'label', text: '山の名前'
      assert_select 'input[type=text][name=?]', 'mntevent[mnt]'
      assert_select 'input[type=hidden][name=?][value=?]', 'mntevent[user_id]', @user.id.to_s
      assert_select 'input[type=submit]'
    end
    assert_select 'a[href=?]', mntevents_path, text: '山行記録一覧に戻る'
  end
end