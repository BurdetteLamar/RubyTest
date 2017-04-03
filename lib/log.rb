require 'rexml/document'
require 'minitest/assertions'

require_relative 'base_class'

require_relative '../test/assertion_helper'

require_relative 'helpers/hash_helper'
require_relative 'helpers/set_helper'

## Class to support XML logging.
#
# === About Volatility
#
# For some verdicts, the actual value is expected to be different each time the \test is run.
# For example, the GUID for an object created in an application be different each time.
#
# By default, such a verdict would always be evaluated as _changed_,
# because its actual values in the previous and current \test runs will always differ.
#
# To control this, you can call a verdict method with argument +volatile+ as +true+,
# in which case the successive verdicts will be evaluated an unchanged.
#
# === About *args
# Method section and all verdict methods pass a final argument *+args+
# whose content is eventually passed to method put_element.
# See how that content is handled by viewing the documentation at put_element.
#
# === About Aliases
# For clarity, the verdict methods that correspond to methods in Minitest::Assertions
# have longish names that clearly indicate the correspondence.
# Method verdict_assert_in_delta?, for example,
# corresponds to assertion method assert_in_delta.
#
# To aid both the \test developer and the IDE's code-completion efforts,
# each such method has a shorter alias.
# Thus method verdict_assert_in_delta? has alias va_in_delta?,
# and method verdict_refute_in_delta? has alias vr_in_delta?.
class Log < BaseClass

  # :stopdoc:

  attr_accessor \
    :assertions,
    :counts,
    :file,
    :file_path,
    :root_name,
    :section_numbers,
    :test,
    :verdict_ids,
    :xml_indentation

  include REXML
  include Minitest::Assertions

  DEFAULT_FILE_NAME = 'log.xml'
  DEFAULT_DIR_PATH = '.'
  DEFAULT_XML_ROOT_TAG_NAME = 'log'
  DEFAULT_XML_INDENTATION = -1

  # Custom contract type for verdict id.
  VERDICT_ID = Or[Symbol, String]
  # Custom contract type for verdict message.
  VERDICT_MESSAGE = Or[Symbol, String]
  # Custom contract type for verdict volatility.
  VERDICT_VOLATILE = Maybe[Bool]
  # Custom contract type for put_element args.
  ARGS = Args[Any]

  # Message for no block error.
  NO_BLOCK_GIVEN_MSG = 'No block given'
  # Message for calling-new error.
  NO_NEW_MSG = format('Please use %s.open, not %s.new.', self.class.name, self.class.name)

  # :startdoc:

  Contract MiniTest::Test, Maybe[Or[Hash, Proc]], Maybe[Proc] => NilClass
  # Callers should call this method, not method +new+.
  # Options can include:
  # - :file_path => _path_.
  # - :root_name => _root-xml-tag-name_.
  # - :xml_indentation => Integer:  indentation for nesting XML sub-elements.
  def self.open(test, options=Hash.new)
    raise NO_BLOCK_GIVEN_MSG unless (block_given?)
    default_options = Hash[
        :file_path => File.join(DEFAULT_DIR_PATH, DEFAULT_FILE_NAME),
        :root_name => DEFAULT_XML_ROOT_TAG_NAME,
        :xml_indentation => DEFAULT_XML_INDENTATION
    ]
    options = default_options.merge(options)
    log = self.new(test, options, im_ok_youre_not_ok = true)
    yield log
    log.send(:dispose)
    nil
  end

  Contract String, ARGS => nil
  # \Log an XML element.
  # - +element_name+:  Element name for logged element.
  # - *+args+:  Anything;  processed left to right;  for each _arg_:
  #   - +Hash+:  becomes element attributes.
  #   - +String+:  appended to PCDATA.
  #   - +:timestamp+:  causes a timestamp to be added to the element.
  #   - +:duration+:  causes block's duration to be added to the element.
  #   - +:rescue+:  causes any exception in block to be rescued and logged.
  #   - else:  _arg_.inspect is appended to PCDATA.
  def put_element(element_name = 'element', *args)
    attributes = {}
    pcdata = ''
    start_time = nil
    duration_to_be_included = false
    block_to_be_rescued = false
    args.each do |arg|
      case
        when arg.kind_of?(Hash)
          attributes.merge!(arg)
        when arg.kind_of?(String)
          pcdata += arg
        when arg == :timestamp
          attributes[:timestamp] = Log.timestamp
        when arg == :duration
          duration_to_be_included = true
        when arg == :rescue
          block_to_be_rescued = true
        else
          pcdata = pcdata + arg.inspect
      end
    end
    log_puts("BEGIN\t#{element_name}")
    put_attributes(attributes)
    unless pcdata.empty?
      # Guard against using a terminator that's a substring of pcdata.
      s = 'EOT'
      terminator = s
      while pcdata.match(terminator) do
        terminator += s
      end
      log_puts("PCDATA\t<<#{terminator}")
      log_puts(pcdata)
      log_puts(terminator)
    end
    start_time = Time.new if duration_to_be_included
    if block_given?
      if block_to_be_rescued
        begin
          yield
        rescue Exception => x
          # Get the verdict id (for the verdict that was attempted).
          verdict_id = nil
          args.each do |arg|
            next unless arg.respond_to?(:each_pair)
            next unless arg.include?(:name)
            verdict_id = arg[:name]
            break
          end
          put_element('uncaught_exception') do
            put_element('verdict_id', verdict_id) if verdict_id
            put_element('class', x.class)
            put_element('http_code', x.http_code) if x.respond_to?(:http_code)
            put_element('http_body', x.http_body) if x.respond_to?(:http_body)
            put_element('message', x.message)
            put_element('backtrace') do
              cdata(filter_backtrace(x.backtrace))
            end
          end
          self.counts[:error] += 1
        end
      else
        yield
      end
    end
    if start_time
      end_time = Time.now
      duration_f = end_time.to_f - start_time.to_f
      duration_s = format('%.3f', duration_f)
      put_attributes({:duration_seconds => duration_s})
    end
    log_puts("END\t#{element_name}")
    nil
  end

  Contract String, ARGS => NilClass
  # Start a \new \section, within the current \section.
  # Sections may be nested.
  def section(name, *args)
    # Note that section numbers can vary among test runs,
    # due to raised exceptions, or to changes to the test themselves.
    # Therefore it's useful only to refer to a section number
    # within the log file for a specific test run.
    self.section_numbers[-1] = self.section_numbers[-1] + 1
    section_number = self.section_numbers.collect {|i| i.to_s}.join('.')
    self.section_numbers.push(0)
    put_element('section', {:name => name, :number => section_number}, *args) do
      yield
    end
    self.section_numbers.pop
    nil
  end

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert.
  def verdict_assert?(verdict_id, actual, message, volatile = false, *args)
    _verdict?(__method__, verdict_id, actual, message, volatile, *args)
  end
  alias va? verdict_assert?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute.
  def verdict_refute?(verdict_id, actual, message, volatile = false, *args)
    _verdict?(__method__, verdict_id, actual, message, volatile, *args)
  end
  alias vr? verdict_refute?

  Contract Symbol, VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict?(verdict_method, verdict_id, actual, message, volatile, *args)
    args_hash = {
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_empty.
  def verdict_assert_empty?(verdict_id, actual, message, volatile = false, *args)
    _verdict_empty?(__method__, verdict_id, actual, message, volatile, *args)
  end
  alias va_empty? verdict_assert_empty?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_empty.
  def verdict_refute_empty?(verdict_id, actual, message, volatile = false, *args)
    _verdict_empty?(__method__, verdict_id, actual, message, volatile, *args)
  end
  alias vr_empty? verdict_refute_empty?

  Contract Symbol, VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_empty?(verdict_method, verdict_id, actual, message, volatile, *args)
    args_hash = {
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_empty?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_equal.
  def verdict_assert_equal?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_equal?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias va_equal? verdict_assert_equal?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_equal.
  def verdict_refute_equal?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_equal?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias vr_equal? verdict_refute_equal?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_equal?(verdict_method, verdict_id, expected, actual, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    verdict = _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
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

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_in_delta.
  def verdict_assert_in_delta?(verdict_id, expected, actual, delta, message, volatile = false, *args)
    _verdict_in_delta?(__method__, verdict_id, expected, actual, delta, message, volatile, *args)
  end
  alias va_in_delta? verdict_assert_in_delta?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_in_delta.
  def verdict_refute_in_delta?(verdict_id, expected, actual, delta, message, volatile = false, *args)
    _verdict_in_delta?(__method__, verdict_id, expected, actual, delta, message, volatile, *args)
  end
  alias vr_in_delta? verdict_refute_in_delta?

  Contract Symbol, VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_in_delta?(verdict_method, verdict_id, expected, actual, delta, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
        :delta => delta,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_in_delta?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_in_epsilon.
  def verdict_assert_in_epsilon?(verdict_id, expected, actual, epsilon, message, volatile = false, *args)
    _verdict_in_epsilon?(__method__, verdict_id, expected, actual, epsilon, message, volatile, *args)
  end
  alias va_in_epsilon? verdict_assert_in_epsilon?

  Contract VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_in_epsilon.
  def verdict_refute_in_epsilon?(verdict_id, expected, actual, epsilon, message, volatile = false, *args)
    _verdict_in_epsilon?(__method__, verdict_id, expected, actual, epsilon, message, volatile, *args)
  end
  alias vr_in_epsilon? verdict_refute_in_epsilon?

  Contract Symbol, VERDICT_ID, Num, Num, Num, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_in_epsilon.
  def _verdict_in_epsilon?(verdict_method, verdict_id, expected, actual, epsilon, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
        :epsilon => epsilon,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_in_epsilon?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_includes.
  def verdict_assert_includes?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_includes?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias va_includes? verdict_assert_includes?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_includes.
  def verdict_refute_includes?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_includes?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias vr_includes? verdict_refute_includes?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_includes?(verdict_method, verdict_id, expected, actual, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_includes?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_instance_of.
  def verdict_assert_instance_of?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_instance_of?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias va_instance_of? verdict_assert_instance_of?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_instance_of.
  def verdict_refute_instance_of?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_instance_of?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias vr_instance_of? verdict_refute_instance_of?

  Contract Symbol, VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_instance_of?(verdict_method, verdict_id, expected, actual, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_instance_of?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_kind_of.
  def verdict_assert_kind_of?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_kind_of?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias va_kind_of? verdict_assert_kind_of?

  Contract VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_kind_of.
  def verdict_refute_kind_of?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_kind_of?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias vr_kind_of? verdict_refute_kind_of?

  Contract Symbol, VERDICT_ID, Class, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_kind_of?(verdict_method, verdict_id, expected, actual, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_kind_of?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_match.
  def verdict_assert_match?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_match?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias va_match? verdict_assert_match?


  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_match.
  def verdict_refute_match?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_match?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias vr_match? verdict_refute_match?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_match?(verdict_method, verdict_id, expected, actual, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_match?

  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_nil.
  def verdict_assert_nil?(verdict_id, actual, message, volatile = false, *args)
    _verdict_nil?(__method__, verdict_id, actual, message, volatile, *args)
  end
  alias va_nil? verdict_assert_nil?


  Contract VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_nil.
  def verdict_refute_nil?(verdict_id, actual, message, volatile = false, *args)
    _verdict_nil?(__method__, verdict_id, actual, message, volatile, *args)
  end
  alias vr_nil? verdict_refute_nil?

  Contract Symbol, VERDICT_ID, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_nil?(verdict_method, verdict_id, actual, message, volatile, *args)
    args_hash = {
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_nil?

  Contract VERDICT_ID, Object, Symbol, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_operator.
  def verdict_assert_operator?(verdict_id, object_1, operator, object_2, message, volatile = false, *args)
    _verdict_operator?(__method__, verdict_id, object_1, operator, object_2, message, volatile, *args)
  end
  alias va_operator? verdict_assert_operator?

  Contract VERDICT_ID, Object, Symbol, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_operator.
  def verdict_refute_operator?(verdict_id, object_1, operator, object_2, message, volatile = false, *args)
    _verdict_operator?(__method__, verdict_id, object_1, operator, object_2, message, volatile, *args)
  end
  alias vr_operator? verdict_refute_operator?

  Contract Symbol, VERDICT_ID, Object, Symbol, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_operator?(verdict_method, verdict_id, object_1, operator, object_2, message, volatile, *args)
    args_hash = {
        :object_1 => object_1,
        :operator => operator,
        :object_2 => object_2
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_operator?

  Contract VERDICT_ID, Maybe[String], Maybe[String], VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_output.
  def verdict_assert_output?(verdict_id, stdout, stderr, message, volatile = false, *args)
    _verdict_output?(__method__, verdict_id, stdout, stderr, message, volatile, *args) do
      yield
    end
  end
  alias va_output? verdict_assert_output?

  # Minitest::Assertions does not  have :refute_output.
  # Contract VERDICT_ID, Maybe[String], Maybe[String], VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_output.
  # def verdict_refute_output?(verdict_id, stdout, stderr, message, volatile = false, *args)
  #   _verdict_output?(__method__, verdict_id, stdout, stderr, message, volatile, *args) do
  #     yield
  #   end
  # end
  # alias vr_output? verdict_refute_output?

  Contract Symbol, VERDICT_ID, Maybe[String], Maybe[String], VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_output?(verdict_method, verdict_id, stdout, stderr, message, volatile, *args)
    args_hash = {
        :stdout => stdout,
        :stderr => stderr,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args) do
      yield
    end
  end
  private :_verdict_output?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_predicate.
  def verdict_assert_predicate?(verdict_id, object, operator, message, volatile = false, *args)
    _verdict_predicate?(__method__, verdict_id, object, operator, message, volatile, *args)
  end
  alias va_predicate? verdict_assert_predicate?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_predicate.
  def verdict_refute_predicate?(verdict_id, object, operator, message, volatile = false, *args)
    _verdict_predicate?(__method__, verdict_id, object, operator, message, volatile, *args)
  end
  alias vr_predicate? verdict_refute_predicate?

  Contract Symbol, VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_predicate?(verdict_method, verdict_id, object, operator, message, volatile, *args)
    args_hash = {
        :object => object,
        :operator => operator,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_predicate?

  Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_raises.
  def verdict_assert_raises?(verdict_id, error_class, message, volatile = false, *args)
    _verdict_raises?(__method__, verdict_id, error_class, message, volatile, *args) do
      yield
    end
  end
  alias va_raises? verdict_assert_raises?

  # Minitest::Assertions does not  have :refute_raises.
  # Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_raises.
  # def verdict_refute_raises?(verdict_id, error_class, message, volatile = false, *args)
  #   _verdict_raises?(__method__, verdict_id, error_class, message, volatile, *args) do
  #     yield
  #   end
  # end
  # alias vr_raises? verdict_refute_raises?

  Contract Symbol, VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_raises?(verdict_method, verdict_id, error_class, message, volatile, *args)
    args_hash = {
        :error_class => error_class,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args) do
      yield
    end
  end
  private :_verdict_raises?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_respond_to.
  def verdict_assert_respond_to?(verdict_id, object, method, message, volatile = false, *args)
    _verdict_respond_to?(__method__, verdict_id, object, method, message, volatile, *args)
  end
  alias va_respond_to? verdict_assert_respond_to?

  Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_respond_to.
  def verdict_refute_respond_to?(verdict_id, object, method, message, volatile = false, *args)
    _verdict_respond_to?(__method__, verdict_id, object, method, message, volatile, *args)
  end
  alias vr_respond_to? verdict_refute_respond_to?

  Contract Symbol, VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_respond_to?(verdict_method, verdict_id, object, method, message, volatile, *args)
    args_hash = {
        :object => object,
        :method => method,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_respond_to?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :assert_same.
  def verdict_assert_same?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_same?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias va_same? verdict_assert_same?

  Contract VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # \Log a verdict using :refute_same.
  def verdict_refute_same?(verdict_id, expected, actual, message, volatile = false, *args)
    _verdict_same?(__method__, verdict_id, expected, actual, message, volatile, *args)
  end
  alias vr_same? verdict_refute_same?

  Contract Symbol, VERDICT_ID, Object, Object, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_same?(verdict_method, verdict_id, expected, actual, message, volatile, *args)
    args_hash = {
        :exp_value => expected,
        :act_value => actual,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_same?

  # Method :assert_send is deprecated, and emite a message to that effect.
  # Let's omit it.
  # Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # # \Log a verdict using :assert_send.
  # def verdict_assert_send?(verdict_id, object, method, message, volatile = false, *args)
  #   _verdict_send?(__method__, verdict_id, object, method, message, volatile, *args)
  # end
  # alias va_send? verdict_assert_send?

  # Minitest::Assertions does not have :refute_send.
  # Contract VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  # # \Log a verdict using :refute_send.
  # def verdict_refute_send?(verdict_id, object, method, message, volatile = false, *args)
  #   _verdict_send?(__method__, verdict_id, object, method, message, volatile, *args)
  # end
  # alias vr_send? verdict_refute_send?

  Contract Symbol, VERDICT_ID, Object, Symbol, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS => Bool
  def _verdict_send?(verdict_method, verdict_id, object, method, message, volatile = false, *args)
    args_hash = {
        :send_array => [object, method],
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
  end
  private :_verdict_send?

  Contract VERDICT_ID, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_silent.
  def verdict_assert_silent?(verdict_id, message, volatile = false, *args)
    _verdict_silent?(__method__, verdict_id, message, volatile, *args) do
      yield
    end
  end
  alias va_silent? verdict_assert_silent?

  # Minitest::Assertions does not  have :refute_silent.
  # Contract VERDICT_ID, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_silent.
  # def verdict_refute_silent?(verdict_id, message, volatile = false, *args)
  #   _verdict_output?(__method__, verdict_id, message, volatile, *args) do
  #     yield
  #   end
  # end
  # alias vr_silent? verdict_refute_silent?

  Contract Symbol, VERDICT_ID, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_silent?(verdict_method, verdict_id, message, volatile, *args)
    args_hash = {}
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args) do
      yield
    end
  end
  private :_verdict_silent?

  Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # \Log a verdict using :assert_throws.
  def verdict_assert_throws?(verdict_id, error_class, message, volatile = false, *args)
    _verdict_throws?(__method__, verdict_id, error_class, message, volatile, *args) do
      yield
    end
  end
  alias va_throws? verdict_assert_throws?

  # Minitest::Assertions does not  have :refute_throws.
  # Contract VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  # # \Log a verdict using :refute_throws.
  # def verdict_refute_throws?(verdict_id, error_class, message, volatile = false, *args)
  #   _verdict_throws?(__method__, verdict_id, error_class, message, volatile, *args) do
  #     yield
  #   end
  # end
  # alias vr_throws? verdict_refute_throws?

  Contract Symbol, VERDICT_ID, Class, VERDICT_MESSAGE, VERDICT_VOLATILE, ARGS, Proc => Bool
  def _verdict_throws?(verdict_method, verdict_id, error_class, message, volatile, *args)
    args_hash = {
        :error_class => error_class,
    }
    _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args) do
      yield
    end
  end
  private :_verdict_throws?

  private

  Contract MiniTest::Test, Maybe[Hash], Maybe[Bool] => nil
  # Not normally called directly,
  # but instead called by +self.open+.
  def initialize(test, options=Hash.new, im_ok_youre_not_ok = false)
    unless im_ok_youre_not_ok
      # Caller should call Log.open, not Log.new.
      raise RuntimeError.new(NO_NEW_MSG)
    end
    self.test = test
    self.assertions = 0
    self.file_path = options[:file_path]
    self.root_name = options[:root_name]
    self.xml_indentation = options[:xml_indentation]
    self.file = File.open(self.file_path, 'w')
    log_puts("REMARK\tThis text log is the precursor for an XML log.")
    log_puts("REMARK\tIf the logged process completes, this text will be converted to XML.")
    log_puts("BEGIN\t#{self.root_name}")
    self.counts = Hash[
        :verdict => 0,
        :failure => 0,
        :error => 0,
    ]
    self.section_numbers = [0]
    nil
  end

  def dispose

    puts 'Counts:'
    self.counts.each_pair do |label, count|
      puts format('  %ss %s', label.to_s.capitalize.rjust(10), count.to_s.rjust(6))
    end

    # An error may have caused some 'missed', but does not itself show up as a verdict.
    # Take a verdict here, so that an error will cause a :failed in the log.
    verdict_assert_equal?('error count', 0, self.counts[:error], 'error count')

    # Close the text log.
    log_puts("END\t#{self.root_name}")
    self.file.close

    # Create the xml log.
    document = REXML::Document.new
    File.open(self.file_path, 'r') do |file|
      element = document
      stack = Array.new
      data_a = nil
      terminator = nil
      file.each_line do |line|
        line.chomp!
        line_type, text = line.split("\t", 2)
        case line_type
          when 'REMARK'
            next
          when 'BEGIN'
            element_name = text
            element = element.add_element(element_name)
            stack.push(element)
            if stack.length == 1
              summary_element = element.add_element('summary')
              summary_element.add_attribute('verdicts', self.counts[:verdict].to_s)
              summary_element.add_attribute('failures', self.counts[:failure].to_s)
              summary_element.add_attribute('errors', self.counts[:error].to_s)
            end
          when 'END'
            stack.pop
            element = stack.last
          when 'ATTRIBUTE'
            attr_name, attr_value = text.split("\t", 2)
            element.add_attribute(attr_name, attr_value)
          when 'CDATA'
            stack.push(:cdata)
            data_a = Array.new
            terminator = text.split('<<', 2).last
          when 'PCDATA'
            stack.push(:pcdata)
            data_a = Array.new
            terminator = text.split('<<', 2).last
          when terminator
            data_s = data_a.join("\n")
            data_a = nil
            terminator = nil
            data_type = stack.last
            case data_type
              when :cdata
                cdata = CData.new(data_s)
                element.add(cdata)
              when :pcdata
                element.add_text(data_s)
              else
                # Don't want to raise an exception and spoil the run
            end
            stack.pop
          else
            data_a.push(line) if (terminator)
        end
      end
      document << XMLDecl.default
    end

    File.open(self.file_path, 'w') do |file|
      document.write(file, self.xml_indentation)
    end
    nil
  end

  Contract Symbol, VERDICT_ID, VERDICT_VOLATILE, VERDICT_MESSAGE, HashOf[Symbol, Any], ARGS => Bool
  def _get_verdict?(verdict_method, verdict_id, volatile, message, args_hash, *args)
    assertion_method = assertion_method_for(verdict_method)
    if block_given?
      outcome = get_assertion_outcome(verdict_id, assertion_method, *args_hash.values) do
        yield
      end
    else
      outcome = get_assertion_outcome(verdict_id, assertion_method, *args_hash.values)
    end
    put_element('verdict', {
        :method => verdict_method,
        :outcome => outcome,
        :id => verdict_id,
        :volatile => volatile,
        :message => message,
    },
                *args
    ) do
      args_hash.each_pair do |k, v|
        put_element(k.to_s, v)
      end
    end
    outcome == :passed
  end
  private :_get_verdict?

  Contract HashOf[Symbol, Any], Symbol => nil
  def put_attributes(attributes)
    attributes.each_pair do |name, value|
      value = case
                when value.is_a?(String)
                  value
                when value.is_a?(Symbol)
                  value.to_s
                else
                  value.inspect
              end
      log_puts("ATTRIBUTE\t#{name}\t#{value}")
    end
    nil
  end

  Contract String => nil
  def log_puts(text)
    self.file.puts(text)
    self.file.flush
    nil
  end

  Contract VERDICT_ID => nil
  def validate_verdict_id(verdict_id)
    self.verdict_ids ||= Set.new
    if self.verdict_ids.include?(verdict_id)
      message = format('Duplicate verdict id %s;  must be unique within its test method', verdict_id.inspect)
      raise ArgumentError.new(message)
    end
    self.verdict_ids.add(verdict_id)
    nil
  end

  Contract VERDICT_ID, Symbol, ARGS,  Maybe[Proc] => Symbol
  def get_assertion_outcome(verdict_id, assertion_method, *assertion_args)
    validate_verdict_id(verdict_id)
    self.counts[:verdict] += 1
    outcome = nil
    begin
      if block_given?
        send(assertion_method, *assertion_args) do
          yield
        end
      else
        send(assertion_method, *assertion_args)
      end
      outcome = :passed
    rescue Minitest::Assertion => x
      # p x.class
      # p x.message
      # x.backtrace.each do |x|
      #   p x
      # end
      log_puts("#{assertion_method} #{assertion_args.inspect}")
      self.counts[:failure] += 1
      outcome = :failed
      if x
        put_element('exception') do
          put_element('class', x.class)
          put_element('message', x.message)
          put_element('backtrace') do
            cdata(filter_backtrace(x.backtrace))
          end
        end
      end
    end
    outcome
  end

  Contract String => nil
  def cdata(text)
    # Guard against using a terminator that's a substring of the cdata.
    s = 'EOT'
    terminator = s
    while text.match(terminator) do
      terminator += s
    end
    log_puts("CDATA<<#{terminator}")
    log_puts(text)
    log_puts(terminator)
    nil
  end

  Contract ArrayOf[String], Maybe[ArrayOf[String]] => String
  # Filters lines that are from ruby or log, to make the backtrace more readable.
  def filter_backtrace(lines, words = %w/log ruby/)
    filtered = []
    lines.each do |line|
      unless words.any? { |s| line.include?(s) }
        filtered.push(line)
      end
    end
    # If nothing left, we were (likely?) testing the logging itself,
    # so just filter out ruby.
    if filtered.empty?
      return filter_backtrace(lines, %w/ruby/)
    end
    filtered.join("\n")
  end

  # Return a timestamp string.
  # The important property of this string
  # is that it can be incorporated into a legal directory path
  # (i.e., has no colons, etc.).
  Contract None => String
  def self.timestamp
    now = Time.now
    ts = now.strftime('%Y-%m-%d-%a-%H.%M.%S')
    usec_s = (now.usec / 1000).to_s
    while usec_s.length < 3 do
      usec_s = '0' + usec_s
    end
    # noinspection RubyUnusedLocalVariable
    ts += ".#{usec_s}"
  end

  def assertion_method_for(verdict_method)
    # Our verdict method name is just an assertion method name
    # with prefixed 'verdict_' and suffixed '?'.
    # Just remove them to form the assertion method name.
    verdict_method.to_s.sub('verdict_', '').sub('?', '').to_sym
  end

end
