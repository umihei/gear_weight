# test/features/mntevent_creation_test.rb
require 'test_helper'

class MnteventCreationTest < ActionDispatch::IntegrationTest
    
  include Devise::Test::IntegrationHelpers
    setup do
      @user = users(:example_user)
      sign_in @user
    # @gear = gears(:example_gear)
    # @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    
    # @mntevent = mntevents(:one) # テストデータの準備（fixtures/mntevents.ymlに定義されたデータを使用）
  end
    
  p 'mntevent creation test'
  test 'create new mntevent' do
    visit new_mntevent_path

    fill_in 'mntevent[eventname]', with: 'My Mountain Event'
    fill_in 'mntevent[eventdate]', with: '2023-06-25'
    fill_in 'mntevent[mnt]', with: 'Mount Everest'

    click_button 'Create Mntevent'
    
    assert_current_path mntevent_path(1)

    # assert_text 'Mntevent created successfully.'
  end

  test 'create new mntevent with invalid data' do
    visit new_mntevent_path

    click_button 'commit'

    assert_text "Eventname can't be blank"
    assert_text "Eventdate can't be blank"
    assert_text "Mnt can't be blank"
  end

  test 'return to mntevent index' do
    visit new_mntevent_path

    click_link '山行記録一覧に戻る'

    assert_current_path mntevents_path
  end
end
