# テストファイル: test/features/mntevents_test.rb

require "application_system_test_case"

class MnteventsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:example_user)
    sign_in @user
    # @gear = gears(:example_gear)
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    
    # @mntevent = mntevents(:one) # テストデータの準備（fixtures/mntevents.ymlに定義されたデータを使用）
  end

  test "山行記録ページの表示とギアの登録リンクのクリック" do
    visit mntevent_path(@mntevent)

    assert_selector "h1", text: "山行記録"
    assert_text @mntevent.eventname
    assert_text @mntevent.eventdate
    assert_text @mntevent.mnt

    assert_selector "table" do
      assert_selector "th", text: "ギア名"
      assert_selector "th", text: "重さ"

      @mntevent.gears.each do |gear|
        assert_selector "td", text: gear.name
        assert_selector "td", text: gear.weight
        assert_link "編集", href: edit_gear_path(gear)
      end
    end

    assert_text "ギアの総重量：#{@mntevent.total_weight}"

    click_link "ギアの登録"

    assert_current_path new_gear_path(mntevents_id: @mntevent.id)
  end
end
