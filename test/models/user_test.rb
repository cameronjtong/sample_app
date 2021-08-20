require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name: "Example", email: "user@example.com")
  end
  
  test "user is valid" do 
    assert @user.valid?
  end
  
  test "name should be present" do 
    @user.name = '    '
    assert_not @user.valid?
  end
  
  test "email should be present" do 
    @user.email = '    '
    assert_not @user.valid?
  end
  
  test "name should not be too long" do 
    @user.name = "a" * 51 
    assert_not @user.valid?
  end
  
  test "email should not be too long" do 
    @user.email = "a" * 51
    assert_not @user.valid?
  end
  
  test "email validation should accept valid emails" do 
    valid_addresses = %w[foo@foo.com cameron@hotmail.com user@user.com ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end
  test "email validation should reject invalid emails" do 
  invalid_addresses = %w[user@example,com user@example..com user_at_foo.org user.name@example. 
                                    foo@bar_baz.com foo@bar+baz.com]
invalid_addresses.each do |invalid_address|
  @user.email = invalid_address
  assert_not @user.valid?, "#{invalid_address} is not valid"
end
end

  test "email addresses must be unique" do 
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses are downcased before save" do 
    mixed_case_email = "Foo@Example.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end


