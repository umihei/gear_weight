class UserGearsIndexViewTest < ActionDispatch::IntegrationTest
  def setup
    # テストに必要なデータのセットアップ
    # @user = users(:example_user) # 適切なユーザーオブジェクトを指定
    # @user_gears = @user.gears # 適切なギアオブジェクトのコレクションを指定
    
    @user = users(:example_user)
    # @gear = gears(:example_gear)
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    @user_gears = Gear.create(name: "gearname", weight: 80, mntevents_id: @mntevent.id, user_id: @user.id)
    @user.gears << @user_gears
    
  end

  test "should display user's gear list" do
    get gears_path(@user.id)

    assert_response :success
    assert_select 'h1', text: "#{@user.username}さんのギア一覧"
    assert_select 'table' do
      assert_select 'th', text: 'ID'
      assert_select 'th', text: 'ギア名'
      assert_select 'th', text: '重さ'
      @user_gears.each do |gear|
        assert_select 'tr' do
          assert_select 'td', text: gear.id.to_s
          assert_select 'td', text: gear.name
          assert_select 'td', text: gear.weight.to_s
          assert_select 'td a[href=?]', gear_path(gear), text: '詳細'
          assert_select 'td a[href=?]', edit_gear_path(gear), text: '編集'
          assert_select 'td a[href=?][data-turbo-method="delete"]', gear_path(gear), text: '削除'
        end
      end
    end
    assert_select 'a[href=?]', mntevents_path, text: '山行記録一覧へ戻る'
  end
end