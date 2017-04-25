require_relative 'constants'

module VerdictBoolean

  # TODO:  Create test for this module.
  # TODO:  Create examples for this module.

  Contract VERDICT_ID, Any, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict asserting a boolean.
  def verdict_assert_boolean?(verdict_id, actual, message, volatile = false, *args)
    boolean_classes = [
        TrueClass,
        FalseClass,
    ]
    va_includes?(verdict_id, boolean_classes, actual.class, message, volatile, *args)
  end
  alias va_boolean? verdict_assert_boolean?

end
