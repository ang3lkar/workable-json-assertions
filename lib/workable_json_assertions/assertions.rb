require 'active_support/core_ext/hash/indifferent_access'

module WorkableJsonAssertions
  module Assertions

    def assert_json_response_empty
      assert_empty response.body.strip
    end

    def assert_json_response_equal(json)
      json = json.with_indifferent_access if json.is_a?(Hash)
      assert_equal json, JSON.parse(response.body.strip)
    end

    def assert_json_response_equal_except(json, blacklist = [])
      json = json.with_indifferent_access if json.is_a?(Hash)
      assert_json_equal_except(json, JSON.parse(response.body), blacklist)
    end

    def assert_json_response_includes(hash)
      assert_match hash.to_json, response.body
    end

    private

    def assert_json_equal_except(json1, json2, blacklist = [])
      json1 = recursive_except(json1, blacklist)
      json2 = recursive_except(json2, blacklist)
      assert_equal json1, json2
    end

    def recursive_except(obj, blacklist)
      case obj
      when Hash
        obj = obj.with_indifferent_access
        obj.each do |k, v|
          obj[k] = recursive_except(v, blacklist)
        end.except(*blacklist)
      when Array
        obj.map do |i|
          recursive_except(i, blacklist)
        end
      else
        obj
      end
    end
  end
end
