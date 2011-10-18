require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase

  test "should create valid admin" do
    admin = Administrator.create(administrators(:one).attributes)
    assert admin.save
  end

  test "should not create admin with no user id" do
    admin = Administrator.create(administrators(:noUser).attributes)
    assert !admin.save
  end

  test "should not create admin with invalid user id" do
    admin = Administrator.create(administrators(:noExist).attributes)
    assert !admin.save
  end

  test "should allow unique admins" do
    admin1 = Administrator.create(administrators(:one).attributes)
    admin1.save
    admin2 = Administrator.create(administrators(:one).attributes)
    assert !admin2.save
  end

end
