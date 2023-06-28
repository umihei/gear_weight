require 'test_helper'

class MnteventTest < ActiveSupport::TestCase
  def setup
    @user = users(:example_user)
    # @mntevent = Mntevent.new(eventname: "Event 1", eventdate: "2023-06-21", mnt: "mnt", user_id: @user.id)
    @mntevent = Mntevent.create(eventname:"testevent", eventdate: "2023-06-30", mnt: "test", total_weight: 30, user_id: @user.id)
  end

  test "should be valid" do
    assert @mntevent.valid?
  end

  test "eventname should be present" do
    @mntevent.eventname = ""
    assert_not @mntevent.valid?
  end

  test "eventdate should be present" do
    @mntevent.eventdate = nil
    assert_not @mntevent.valid?
  end

  test "mnt should be present" do
    @mntevent.mnt = nil
    assert_not @mntevent.valid?
  end

  test "total_weight should be an integer" do
    @mntevent.total_weight = "abc"
    assert_not @mntevent.valid?
  end

  test "should have gears" do
    assert_equal 0, @mntevent.gears.count

    gear = Gear.new(name: "Gear 1", weight: 10, mntevents_id: @mntevent.id, user_id: @user.id)
    @mntevent.gears << gear

    assert_equal 1, @mntevent.gears.count
  end

  test "should belong to a user" do
    assert_equal @user, @mntevent.user
  end
end