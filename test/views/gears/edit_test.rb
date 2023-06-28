require 'test_helper'

class GearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gear = gears(:one) # Replace with your fixture or create a gear record
    @mntevents_id = 1
  end

  test 'should get edit form' do
    get edit_gear_path(@gear)
    assert_response :success
    assert_select 'h1', 'ギアの編集'
    assert_select 'form[action=?][method=?]', gear_path(@gear), 'post' do
      assert_select 'input[name=?][value=?]', 'gear[name]', @gear.name
      assert_select 'input[name=?][value=?]', 'gear[weight]', @gear.weight.to_s
      assert_select 'input[type=?]', 'hidden', count: 2
      assert_select 'input[type=?][value=?]', 'hidden', @mntevents_id.to_s
      assert_select 'input[type=?][value=?]', 'hidden', current_user.id.to_s
      assert_select 'input[type=?][value=?]', 'submit'
    end
    assert_select 'a[href=?]', mntevent_path(@mntevents_id)
  end

  test 'should update gear' do
    gear_params = {
      gear: {
        name: 'Updated Gear',
        weight: 20,
        mntevents_id: @mntevents_id,
        user_id: current_user.id
      }
    }

    patch gear_path(@gear), params: gear_params
    assert_redirected_to mntevent_path(@mntevents_id)
    assert_equal 'Updated Gear', @gear.reload.name
    assert_equal 20, @gear.reload.weight
    # Add more assertions as needed
  end
end