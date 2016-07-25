# WorkableJsonAssertions

This gem adds basic JSON assertions to your controller tests.

## Installation

Add this line to your application's Gemfile:

    gem 'workable_json_assertions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workable_json_assertions

## Usage

### assert\_json\_response_empty
```ruby
class BasicControllerTest < ActionController::TestCase
	def test_success
		get :index # {}
		assert_json_response_empty
	end
end
```

### assert\_json\_response_equal
```ruby
class BasicControllerTest < ActionController::TestCase
	def test_success
		get :index # { 'key': 'value' }
		assert_json_response_equal { key: 'value' }
	end
end
```

### assert\_json\_response\_equal_except
```ruby
class BasicControllerTest < ActionController::TestCase
	def test_success
		get :index # { 'key': 'value', 'created_at': '2016-07-25', 'updated_at': '2016-07-26' }
		assert_json_response_equal_except { key: 'value' }, %i(created_at updated_at)
	end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
