require 'active_support/lazy_load_hooks'
require 'workable_json_assertions/assertions'
require 'workable_json_assertions/version'

ActiveSupport.on_load(:action_controller) do
  ActionController::TestCase.send(:include, WorkableJsonAssertions::Assertions)
end
