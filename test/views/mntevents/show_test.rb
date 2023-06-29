class MnteventShowViewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example_user)
    # @gear = gears(:example_gear)
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    @gear = Gear.create(name: "gearname", weight: 80, mntevents_id: @mntevent.id, user_id: @user.id)
    @mntevent.gears << @gear
    
    # # テストに必要なデータのセットアップ
    # @mntevent = mntevents(:test_mntevent) # 適切な山行記録オブジェクトを指定
    # @gears = @mntevent.gears # 山行記録に関連するギアのオブジェクトを指定

    # 必要なデータが正しく設定されていることを確認
    # assert_not_empty @gears
  end

  test "should display mountain event details" do
    get mntevent_path(@mntevent)

    assert_response :success
    assert_select 'h1', text: '山行記録'
    assert_select 'p', count: 4
    assert_select 'table', count: 1
    assert_select 'th', text: 'ギア名'
    assert_select 'th', text: '重さ'
    assert_select 'p', text: "ギアの総重量：#{@mntevent.total_weight}"
    assert_select 'a[href=?]', new_gear_path(mntevents_id: @mntevent.id), text: 'ギアの登録'
    assert_select 'a[href=?]', mntevents_path, text: '山行記録一覧へ戻る'
  end
end