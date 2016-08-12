require 'test_helper'

class JsonControllerTest < ActionController::TestCase

  def test_json_response_empty
    process :empty_response
    assert_json_response_empty

    process :dummy_response
    assert_raise(ActiveSupport::TestCase::Assertion) do
      assert_json_response_empty
    end
  end

  def test_json_response_equal
    process :dummy_response
    assert_json_response_equal expected_response
    assert_raise(ActiveSupport::TestCase::Assertion) do
      assert_json_response_equal slightly_altered_expected_response
    end
  end

  def test_json_response_equal_except
    process :dummy_response
    assert_json_response_equal_except slightly_altered_expected_response, %i(three four)
    assert_raise(ActiveSupport::TestCase::Assertion) do
      assert_json_response_equal_except slightly_altered_expected_response, %i(one two)
    end
  end

  def test_json_response_includes
    process :another_response
    assert_json_response_includes({ name: 'John', instrument: 'Guitar' })
  end

  private

  def expected_response
    {
      one:    'John',
      two:    'Paul',
      three:  'George',
      four:   'Ringo'
    }
  end

  def slightly_altered_expected_response
    {
      one:    'John',
      two:    'Paul',
      three:  'George Harrison',
      four:   'Ringo Star'
    }
  end
end
