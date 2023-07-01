require 'test_helper'

class MnteventListViewTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers
  test 'should display user mountain event list' do
    
    user = users(:example_user)
    sign_in user
    mntevent1 = Mntevent.create(eventname:"testevent1", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: user.id)
    mntevent2 = Mntevent.create(eventname:"testevent2", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: user.id)

    # テスト用データの作成
    user.mntevent << [mntevent1, mntevent2]

    # テスト用データを使用してページを表示
    visit mntevents_path(user)

    # ヘッダーの表示を検証
    assert_selector 'h1', text: "#{user.username}さんの山行記録一覧"

    # テーブルの表示を検証
    assert_selector 'table' do
      # ヘッダーの列を検証
      assert_selector 'th', text: 'ID'
      assert_selector 'th', text: '山行名'
      assert_selector 'th', text: '山行日'
      assert_selector 'th', text: '山名'
      assert_selector 'th', text: 'ギア総重量'

      # データの行を検証
      assert_selector 'tr', count: 3 # ヘッダー行 + データ行2つ
      assert_selector 'tr>td', text: mntevent1.id.to_s
      assert_selector 'tr>td', text: mntevent1.eventname
      assert_selector 'tr>td', text: mntevent1.eventdate.to_s
      assert_selector 'tr>td', text: mntevent1.mnt
      assert_selector 'tr>td', text: mntevent1.total_weight.to_s
    end

    # リンクの表示を検証
    assert_link '詳細', href: mntevent_path(mntevent1)
    assert_link '編集', href: edit_mntevent_path(mntevent1)
    assert_link '削除', href: mntevent_path(mntevent1)

    # 他のリンクの表示を検証
    assert_link '新しい山行記録の作成', href: new_mntevent_path
    assert_link 'ギア一覧', href: gears_path
  end
end