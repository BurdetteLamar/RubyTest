module VerdictInteger

  def verdict_assert_integer_positive?(verdict_id, actual, message, volatile = false, *args)
    passed = true
    section(__method__.to_s) do
      passed = va_kind_of?(verdict_id + ' - integer', Fixnum, actual, message, volatile, *args) && passed
      passed = va_operator?(verdict_id + ' - positive', actual, :>, 0, message, volatile, *args) && passed
    end
    passed
  end
  alias va_integer_positive? verdict_assert_integer_positive?

end