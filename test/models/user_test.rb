require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "test@example.com", password: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "should have many mntevents" do
    assert_respond_to @user, :mntevent
  end

  test "should have many gears" do
    assert_respond_to @user, :gear
  end
end