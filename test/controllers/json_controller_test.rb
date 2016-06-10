require 'test_helper'

class JsonControllerTest < ActionController::TestCase

  def test_assert_timestamp_fields
    process :timestamps

    assert_timestamp_fields
  end
end
