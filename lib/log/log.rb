require 'rexml/document'
require 'minitest/assertions'

require_relative '../base_class'

require_relative '../../test/assertion_helper'

require_relative '../helpers/hash_helper'
require_relative '../helpers/set_helper'

require_relative 'constants'
require_relative 'verdict_assertion'
require_relative 'verdict_boolean'
require_relative 'verdict_integer'
require_relative 'verdict_string'

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

  include VerdictAssertion
  include VerdictBoolean
  include VerdictInteger
  include VerdictString

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

  Contract Args[Any] => NilClass
  def test_method(*args)
    put_element('test_method', *args) do
      yield
    end
    nil
  end

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

    puts 'Counts for %s:' % TestHelper.get_test_name
      self.counts.each_pair do |label, count|
      puts format('  %ss %s', label.to_s.capitalize.rjust(10), count.to_s.rjust(6))
    end

    # An error may have caused some blocked verdicts, but does not itself show up as a verdict.
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
    log_puts("CDATA\t<<#{terminator}")
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
