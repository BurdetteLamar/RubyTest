require_relative 'constants'

# noinspection RubyTooManyMethodsInspection
module VerdictAssertion

  # TODO:  Separate testing for this module from that for Log class.
  # TODO:  Separate examples for this module from those for Log class.

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert.
  def verdict_assert?(verdict_id, actual, message: nil, volatile: false)
    _verdict?(__method__, verdict_id, actual, message, volatile)
  end
  alias va? verdict_assert?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute.
  def verdict_refute?(verdict_id, actual, message: nil, volatile: false)
    _verdict?(__method__, verdict_id, actual, message, volatile)
  end
  alias vr? verdict_refute?

  Contract Symbol, VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict?(verdict_method, verdict_id, actual, message, volatile)
    args_hash = {
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_empty.
  def verdict_assert_empty?(verdict_id, actual, message: nil, volatile: false)
    _verdict_empty?(__method__, verdict_id, actual, message, volatile)
  end
  alias va_empty? verdict_assert_empty?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_empty.
  def verdict_refute_empty?(verdict_id, actual, message: nil, volatile: false)
    _verdict_empty?(__method__, verdict_id, actual, message, volatile)
  end
  alias vr_empty? verdict_refute_empty?

  Contract Symbol, VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_empty?(verdict_method, verdict_id, actual, message, volatile)
    args_hash = {
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_empty?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_equal.
  def verdict_assert_equal?(verdict_id, expected, actual, message: nil, volatile: false)
    if expected.nil?
      # Minitest warns if we try to test for nil.
      verdict_assert_nil?(verdict_id, actual, message: message, volatile: volatile)
    else
      _verdict_equal?(__method__, verdict_id, expected, actual, message, volatile)
    end
  end
  alias va_equal? verdict_assert_equal?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_equal.
  def verdict_refute_equal?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_equal?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias vr_equal? verdict_refute_equal?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_equal?(verdict_method, verdict_id, expected, actual, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    verdict = _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
    # Done if passed or refute.
    return verdict if verdict || verdict_method == :verdict_refute_equal?
    # Log analysis of failed complex type.
    case
      when expected.kind_of?(Set) && actual.kind_of?(Set)
        put_element('analysis') do
          SetHelper.compare(expected, actual).each_pair do |key, value|
            put_element(key.to_s, value) unless value.empty?
          end
        end
      when expected.kind_of?(Hash) && actual.kind_of?(Hash)
        put_element('analysis') do
          HashHelper.compare(expected, actual).each_pair do |key, value|
            put_element(key.to_s, value) unless value.empty?
          end

        end
      else
        # TODO:  Implement more here as needed;  Array, etc.
    end
    verdict
  end
  private :_verdict_equal?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_in_delta.
  def verdict_assert_in_delta?(verdict_id, expected, actual, delta, message: nil, volatile: false)
    _verdict_in_delta?(__method__, verdict_id, expected, actual, delta, message, volatile)
  end
  alias va_in_delta? verdict_assert_in_delta?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_in_delta.
  def verdict_refute_in_delta?(verdict_id, expected, actual, delta, message: nil, volatile: false)
    _verdict_in_delta?(__method__, verdict_id, expected, actual, delta, message, volatile)
  end
  alias vr_in_delta? verdict_refute_in_delta?

  Contract Symbol, VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_in_delta?(verdict_method, verdict_id, expected, actual, delta, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
        :delta => delta,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_in_delta?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_in_epsilon.
  def verdict_assert_in_epsilon?(verdict_id, expected, actual, epsilon, message: nil, volatile: false)
    _verdict_in_epsilon?(__method__, verdict_id, expected, actual, epsilon, message, volatile)
  end
  alias va_in_epsilon? verdict_assert_in_epsilon?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_in_epsilon.
  def verdict_refute_in_epsilon?(verdict_id, expected, actual, epsilon, message: nil, volatile: false)
    _verdict_in_epsilon?(__method__, verdict_id, expected, actual, epsilon, message, volatile)
  end
  alias vr_in_epsilon? verdict_refute_in_epsilon?

  Contract Symbol, VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_in_epsilon.
  def _verdict_in_epsilon?(verdict_method, verdict_id, expected, actual, epsilon, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
        :epsilon => epsilon,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_in_epsilon?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_includes.
  def verdict_assert_includes?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_includes?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias va_includes? verdict_assert_includes?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_includes.
  def verdict_refute_includes?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_includes?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias vr_includes? verdict_refute_includes?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_includes?(verdict_method, verdict_id, expected, actual, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_includes?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_instance_of.
  def verdict_assert_instance_of?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_instance_of?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias va_instance_of? verdict_assert_instance_of?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_instance_of.
  def verdict_refute_instance_of?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_instance_of?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias vr_instance_of? verdict_refute_instance_of?

  Contract Symbol, VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_instance_of?(verdict_method, verdict_id, expected, actual, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_instance_of?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_kind_of.
  def verdict_assert_kind_of?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_kind_of?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias va_kind_of? verdict_assert_kind_of?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_kind_of.
  def verdict_refute_kind_of?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_kind_of?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias vr_kind_of? verdict_refute_kind_of?

  Contract Symbol, VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_kind_of?(verdict_method, verdict_id, expected, actual, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_kind_of?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_match.
  def verdict_assert_match?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_match?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias va_match? verdict_assert_match?


  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_match.
  def verdict_refute_match?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_match?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias vr_match? verdict_refute_match?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_match?(verdict_method, verdict_id, expected, actual, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_match?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_nil.
  def verdict_assert_nil?(verdict_id, actual, message: nil, volatile: false)
    _verdict_nil?(__method__, verdict_id, actual, message, volatile)
  end
  alias va_nil? verdict_assert_nil?


  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_nil.
  def verdict_refute_nil?(verdict_id, actual, message: nil, volatile: false)
    _verdict_nil?(__method__, verdict_id, actual, message, volatile)
  end
  alias vr_nil? verdict_refute_nil?

  Contract Symbol, VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_nil?(verdict_method, verdict_id, actual, message, volatile)
    args_hash = {
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_nil?

  Contract VERDICT_ID, Object, Symbol, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_operator.
  def verdict_assert_operator?(verdict_id, object_1, operator, object_2, message: nil, volatile: false)
    _verdict_operator?(__method__, verdict_id, object_1, operator, object_2, message, volatile)
  end
  alias va_operator? verdict_assert_operator?

  Contract VERDICT_ID, Object, Symbol, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_operator.
  def verdict_refute_operator?(verdict_id, object_1, operator, object_2, message: nil, volatile: false)
    _verdict_operator?(__method__, verdict_id, object_1, operator, object_2, message, volatile)
  end
  alias vr_operator? verdict_refute_operator?

  Contract Symbol, VERDICT_ID, Object, Symbol, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_operator?(verdict_method, verdict_id, object_1, operator, object_2, message, volatile)
    args_hash = {
        :object_1 => object_1,
        :operator => operator,
        :object_2 => object_2
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_operator?

  Contract VERDICT_ID, Maybe[String], Maybe[String], VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_output.
  def verdict_assert_output?(verdict_id, stdout, stderr, message: nil, volatile: false)
    _verdict_output?(__method__, verdict_id, stdout, stderr, message, volatile) do
      yield
    end
  end
  alias va_output? verdict_assert_output?

  # Minitest::Assertions does not  have :refute_output.
  # Contract VERDICT_ID, Maybe[String], Maybe[String], VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_output.
  # def verdict_refute_output?(verdict_id, stdout, stderr, message: nil, volatile: false)
  #   _verdict_output?(__method__, verdict_id, stdout, stderr, message, volatile) do
  #     yield
  #   end
  # end
  # alias vr_output? verdict_refute_output?

  Contract Symbol, VERDICT_ID, Maybe[String], Maybe[String], VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_output?(verdict_method, verdict_id, stdout, stderr, message, volatile)
    args_hash = {
        :stdout => stdout,
        :stderr => stderr,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash) do
      yield
    end
  end
  private :_verdict_output?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_predicate.
  def verdict_assert_predicate?(verdict_id, object, operator, message: nil, volatile: false)
    _verdict_predicate?(__method__, verdict_id, object, operator, message, volatile)
  end
  alias va_predicate? verdict_assert_predicate?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_predicate.
  def verdict_refute_predicate?(verdict_id, object, operator, message: nil, volatile: false)
    _verdict_predicate?(__method__, verdict_id, object, operator, message, volatile)
  end
  alias vr_predicate? verdict_refute_predicate?

  Contract Symbol, VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_predicate?(verdict_method, verdict_id, object, operator, message, volatile)
    args_hash = {
        :object => object,
        :operator => operator,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_predicate?

  Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_raises.
  def verdict_assert_raises?(verdict_id, error_class, message: nil, volatile: false)
    _verdict_raises?(__method__, verdict_id, error_class, message, volatile) do
      yield
    end
  end
  alias va_raises? verdict_assert_raises?

  # Minitest::Assertions does not  have :refute_raises.
  # Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_raises.
  # def verdict_refute_raises?(verdict_id, error_class, message: nil, volatile: false)
  #   _verdict_raises?(__method__, verdict_id, error_class, message, volatile) do
  #     yield
  #   end
  # end
  # alias vr_raises? verdict_refute_raises?

  Contract Symbol, VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_raises?(verdict_method, verdict_id, error_class, message, volatile)
    args_hash = {
        :error_class => error_class,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash) do
      yield
    end
  end
  private :_verdict_raises?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_respond_to.
  def verdict_assert_respond_to?(verdict_id, object, method, message: nil, volatile: false)
    _verdict_respond_to?(__method__, verdict_id, object, method, message, volatile)
  end
  alias va_respond_to? verdict_assert_respond_to?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_respond_to.
  def verdict_refute_respond_to?(verdict_id, object, method, message: nil, volatile: false)
    _verdict_respond_to?(__method__, verdict_id, object, method, message, volatile)
  end
  alias vr_respond_to? verdict_refute_respond_to?

  Contract Symbol, VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_respond_to?(verdict_method, verdict_id, object, method, message, volatile)
    args_hash = {
        :object => object,
        :method => method,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_respond_to?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :assert_same.
  def verdict_assert_same?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_same?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias va_same? verdict_assert_same?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict using :refute_same.
  def verdict_refute_same?(verdict_id, expected, actual, message: nil, volatile: false)
    _verdict_same?(__method__, verdict_id, expected, actual, message, volatile)
  end
  alias vr_same? verdict_refute_same?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  def _verdict_same?(verdict_method, verdict_id, expected, actual, message, volatile)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  end
  private :_verdict_same?

  # Method :assert_send is deprecated, and emits a message to that effect.
  # Let's omit it.
  # Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # # \Log a verdict using :assert_send.
  # def verdict_assert_send?(verdict_id, object, method, message: nil, volatile: false)
  #   _verdict_send?(__method__, verdict_id, object, method, message, volatile)
  # end
  # alias va_send? verdict_assert_send?

  # Minitest::Assertions does not have :refute_send.
  # Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # # \Log a verdict using :refute_send.
  # def verdict_refute_send?(verdict_id, object, method, message: nil, volatile: false)
  #   _verdict_send?(__method__, verdict_id, object, method, message, volatile)
  # end
  # alias vr_send? verdict_refute_send?
  #
  # Contract Symbol, VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # def _verdict_send?(verdict_method, verdict_id, object, method, message, volatile)
  #   args_hash = {
  #       :send_array => [object, method],
  #   }
  #   _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash)
  # end
  # private :_verdict_send?

  Contract VERDICT_ID, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_silent.
  def verdict_assert_silent?(verdict_id, message: nil, volatile: false)
    _verdict_silent?(__method__, verdict_id, message, volatile) do
      yield
    end
  end
  alias va_silent? verdict_assert_silent?

  # Minitest::Assertions does not  have :refute_silent.
  # Contract VERDICT_ID, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_silent.
  # def verdict_refute_silent?(verdict_id, message: nil, volatile: false)
  #   _verdict_output?(__method__, verdict_id, message, volatile) do
  #     yield
  #   end
  # end
  # alias vr_silent? verdict_refute_silent?

  Contract Symbol, VERDICT_ID, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_silent?(verdict_method, verdict_id, message, volatile)
    args_hash = {}
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash) do
      yield
    end
  end
  private :_verdict_silent?

  Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_throws.
  def verdict_assert_throws?(verdict_id, error_class, message: nil, volatile: false)
    _verdict_throws?(__method__, verdict_id, error_class, message, volatile) do
      yield
    end
  end
  alias va_throws? verdict_assert_throws?

  # Minitest::Assertions does not  have :refute_throws.
  # Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_throws.
  # def verdict_refute_throws?(verdict_id, error_class, message: nil, volatile: false)
  #   _verdict_throws?(__method__, verdict_id, error_class, message, volatile) do
  #     yield
  #   end
  # end
  # alias vr_throws? verdict_refute_throws?

  Contract Symbol, VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_throws?(verdict_method, verdict_id, error_class, message, volatile)
    args_hash = {
        :error_class => error_class,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash) do
      yield
    end
  end
  private :_verdict_throws?

end