require 'test_helper'
require 'rails-controller-testing'

class MnteventsEditViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
      
    @user = users(:example_user)
    
    @mntevent = Mntevent.create(eventname:"testevent1", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    # @mntevent2 = Mntevent.create(eventname:"testevent2", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    
    # @mntevent1 = mntevents(:mntevent1)
    # @mntevent2 = mntevents(:mntevent2)
    sign_in @user
    # # テストに必要なデータのセットアップ
    # @mntevent = mntevents(:test_mntevent) # 適切な山行記録オブジェクトを指定

    # # ユーザーの認証
    # sign_in users(:test_user)
  end

  test "should display edit mountain event form" do
    get edit_mntevent_path(@mntevent)

    assert_response :success
    assert_select 'h1', text: '山行記録の編集'
    assert_select 'form[action=?][method=?]', mntevent_path(@mntevent), 'post' do
      assert_select 'div', count: 4
      assert_select 'label', text: '山行の名前'
      assert_select 'input[type=text][name=?][value=?]', 'mntevent[eventname]', @mntevent.eventname
      assert_select 'label', text: '山に行った日'
      assert_select 'input[type=date][name=?][value=?]', 'mntevent[eventdate]', @mntevent.eventdate.to_s
      assert_select 'label', text: '山の名前'
      assert_select 'input[type=text][name=?][value=?]', 'mntevent[mnt]', @mntevent.mnt
      assert_select 'input[type=hidden][name=?][value=?]', 'mntevent[user_id]', @user.id.to_s
      assert_select 'input[type=submit]'
    end
    assert_select 'a[href=?]', mntevents_path, text: '山行記録一覧に戻る'
  end
end