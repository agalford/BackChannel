require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid user" do
    user = User.create(users(:one).attributes)
    assert user.save
  end

  test "require first name" do
    user = User.create(users(:noFirst).attributes)
    assert !user.save
  end

  test "require last name" do
    user = User.create(users(:noLast).attributes)
    assert !user.save
  end

  test "require email" do
    user = User.create(users(:noEmail).attributes)
    assert !user.save
  end

  test "unique user" do
    user1 = User.create(users(:one).attributes)
    user1.save
    user2 = User.create(users(:one).attributes)
    assert !user2.save
  end

end
