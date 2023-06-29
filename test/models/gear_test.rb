require 'test_helper'

class GearTest < ActiveSupport::TestCase
  # def setup
  #   @user = users(:example_user)
  #   # @mntevent = Mntevent.new(eventname: "Event 1", eventdate: "2023-06-21", mnt: "mnt", user_id: @user.id)
  #   @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
  # end
  
  def setup
    @user = users(:example_user)
    # @gear = gears(:example_gear)
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
    @gear = Gear.create(name: "gearname", weight: 80, mntevents_id: @mntevent.id, user_id: @user.id)
    @mntevent.gears << @gear
  end

  test "should be valid" do
    assert @gear.valid?
  end

  test "name should be present" do
    @gear.name = nil
    assert_not @gear.valid?
    assert_includes @gear.errors[:name], "can't be blank"
  end

  test "weight should be present" do
    @gear.weight = nil
    assert_not @gear.valid?
    assert_includes @gear.errors[:weight], "can't be blank"
  end

  test "weight should be an integer" do
    @gear.weight = 10.5
    assert_not @gear.valid?
    assert_includes @gear.errors[:weight], "must be an integer"
  end
end