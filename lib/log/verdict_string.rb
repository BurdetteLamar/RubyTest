module VerdictString

  def verdict_refute_string_empty?(verdict_id, actual, message, volatile = false, *args)
    passed = true
    section(__method__.to_s) do
      passed = va_kind_of?(verdict_id + ' - string', String, actual, message, volatile, *args) && passed
      passed = vr_empty?(verdict_id + ' - not empty', actual, message, volatile, *args) && passed
    end
    passed
  end
  alias vr_string_empty? verdict_refute_string_empty?

end
