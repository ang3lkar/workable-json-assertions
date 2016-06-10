require 'active_support/core_ext/hash/indifferent_access'

module WorkableJsonAssertions
  module Assertions
    ISO_8601_PATTERN = /(\d\d\d\d)-?(\d\d)-?(\d\d)T?(\d\d):?(\d\d)(?::?(\d\d)(\.\d+)*?)?(Z|[+-])(?:(\d\d):?(\d\d))?/

    def assert_isodate(str)
      assert_match ISO_8601_PATTERN, str, "#{str} is not an ISO-8601 date"
    end

    def assert_timestamp_fields(obj, *fields)
      if obj.is_a?(Array)
        obj.each do |item|
          assert_timestamp_fields(item, *fields)
        end
        return
      end

      hash = obj.with_indifferent_access

      fields.each do |field|
        assert_match ISO_8601_PATTERN, hash[field], "#{hash[field]} is not an ISO-8601 date"
        assert_kind_of Integer, hash["#{field}_millis"]
        refute_nil hash["#{field}_in_words"]
      end
    end

    def assert_json_equal_except(json1, json2, blacklist = [])
      json1 = recursive_except(json1, blacklist)
      json2 = recursive_except(json2, blacklist)
      assert_equal json1, json2
    end

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

    private

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
