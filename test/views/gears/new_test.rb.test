require 'test_helper'

class GearsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new gear form' do
    mntevents_id = 1
    get new_gear_path(mntevents_id: mntevents_id)
    assert_response :success
    assert_select 'h1', '新しいギアの登録'
    assert_select 'form[action=?][method=?]', gears_path, 'post' do
      assert_select 'input[name=?]', 'gear[name]'
      assert_select 'input[name=?]', 'gear[weight]'
      assert_select 'input[type=?]', 'hidden', count: 2
      assert_select 'input[type=?][value=?]', 'hidden', mntevents_id.to_s
      assert_select 'input[type=?][value=?]', 'hidden', current_user.id.to_s
      assert_select 'input[type=?][value=?]', 'submit'
    end
    assert_select 'a[href=?]', mntevent_path(mntevents_id)
  end

  test 'should create gear' do
    mntevents_id = 1
    gear_params = {
      gear: {
        name: 'Gear 1',
        weight: 10,
        mntevents_id: mntevents_id,
        user_id: 1
      }
    }

    assert_difference('Gear.count') do
      post gears_path, params: gear_params
    end

    assert_redirected_to mntevent_path(mntevents_id)
    assert_equal 'Gear 1', Gear.last.name
    assert_equal 10, Gear.last.weight
    # Add more assertions as needed
  end
end