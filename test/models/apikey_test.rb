require 'test_helper'

class ApikeyTest < ActiveSupport::TestCase
  test "api key should not allow saves if there is no key specified" do
    the_new_key = Apikey.new
    the_new_key.auth_type = 1
    assert_not the_new_key.save
  end

  test "api_key_should_not_allow_saves_if_there_is_no_auth_type" do
    the_new_key = Apikey.new
    the_new_key.token = SecureRandom.hex(10)
    assert_not the_new_key.save
  end

  test "api key should save if there is a token and an auth_type" do
    the_new_key = Apikey.new
    the_new_key.token = SecureRandom.hex(10)
    the_new_key.auth_type = 1
    assert the_new_key.save
  end
end
