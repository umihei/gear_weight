require 'test_helper'
require 'rails-controller-testing'

class MnteventsIndexViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:example_user)
    
    @mntevent1 = Mntevent.create(eventname:"testevent1", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    @mntevent2 = Mntevent.create(eventname:"testevent2", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    
    # @mntevent1 = mntevents(:mntevent1)
    # @mntevent2 = mntevents(:mntevent2)
    sign_in @user
  end

  test 'should display user\'s mountain event records' do
    

    get mntevents_path, headers: { 'HTTP_REFERER': '/'}

    assert_response :success
    assert_select 'h1', text: "#{@user.username}さんの山行記録一覧"
    assert_select 'table' do
      assert_select 'tr', count: 3 # ヘッダー行と2つのデータ行を含むため3行
      assert_select 'th', count: 5 # ID, 山行名, 山行日, 山名, ギア総重量の5つの列を含む
      assert_select 'th', text: 'ID'
      assert_select 'th', text: '山行名'
      assert_select 'th', text: '山行日'
      assert_select 'th', text: '山名'
      assert_select 'th', text: 'ギア総重量'
      assert_select 'td', text: @mntevent1.id.to_s
      assert_select 'td', text: @mntevent1.eventname
      assert_select 'td', text: @mntevent1.eventdate.to_s
      assert_select 'td', text: @mntevent1.mnt
      assert_select 'td', text: @mntevent1.total_weight.to_s
      assert_select 'td a', text: '詳細', href: mntevent_path(@mntevent1)
      assert_select 'td a', text: '編集', href: edit_mntevent_path(@mntevent1)
      assert_select 'td a[data-turbo-method="delete"]', text: '削除', href: mntevent_path(@mntevent1)
      assert_select 'td', text: @mntevent2.id.to_s
      assert_select 'td', text: @mntevent2.eventname
      assert_select 'td', text: @mntevent2.eventdate.to_s
      assert_select 'td', text: @mntevent2.mnt
      assert_select 'td', text: @mntevent2.total_weight.to_s
      assert_select 'td a', text: '詳細', href: mntevent_path(@mntevent2)
      assert_select 'td a', text: '編集', href: edit_mntevent_path(@mntevent2)
      assert_select 'td a[data-turbo-method="delete"]', text: '削除', href: mntevent_path(@mntevent2)
    end

    assert_select 'a', text: '新しい山行記録の作成', href: new_mntevent_path
    assert_select 'a', text: 'ギア一覧', href: gears_path
  end
end