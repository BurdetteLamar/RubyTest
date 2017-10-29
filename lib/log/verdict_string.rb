require_relative 'constants'

module VerdictString

  # TODO:  Create test for this module.
  # TODO:  Create examples for this module.

  Contract VERDICT_ID, Any, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict refuting an empty string.
  def verdict_assert_string_not_empty?(verdict_id, actual, message, volatile = false)
    passed = true
    section(__method__.to_s) do
      passed = va_kind_of?(verdict_id + ' - string', String, actual, message, volatile) && passed
      passed = vr_empty?(verdict_id + ' - not empty', actual, message, volatile) && passed
    end
    passed
  end
  alias va_string_not_empty? verdict_assert_string_not_empty?

  Contract VERDICT_ID, Range, Any, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def verdict_assert_string_length_in_range?(verdict_id, range, actual, message, volatile = false)
    passed = true
    section(__method__.to_s) do
      passed = va_kind_of?(verdict_id + ' - string', String, actual, message, volatile) && passed
      passed = verdict_assert_in_range?(verdict_id + ' - in range', range, actual.size, message, volatile) && passed
    end
    passed
  end

end
