require 'rexml/document'
require 'minitest/assertions'
require 'nokogiri'

require_relative '../base_classes/base_class'

require_relative '../../test/assertion_helper'

require_relative '../helpers/hash_helper'
require_relative '../helpers/set_helper'
require_relative '../helpers/test_helper'

require_relative 'constants'
# When adding a module here, be sure to 'include' below.
require_relative 'verdict_assertion'
require_relative 'verdict_boolean'
require_relative 'verdict_integer'
require_relative 'verdict_range'
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
  include VerdictRange
  include VerdictString

  # :stopdoc:

  attr_accessor \
    :assertions,
    :counts,
    :file,
    :file_path,
    :backtrace_filter,
    :root_name,
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
    put_element('section', {:name => name}, *args) do
      yield
    end
    nil
  end
  Contract String, ARGS => NilClass
  def comment(text, *args)
    put_element('comment', text, *args)
    nil
  end

  Contract Args[Any] => NilClass
  def test_method(*args)
    put_element('test_method', *args) do
      yield
    end
    nil
  end

  def self.verdict_id(*args)
    args.join(' ')
  end

  require_relative '../base_classes/base_class_for_data'
  class Verdict < BaseClassForData

    FIELDS = Set.new([
                         :file_path,
                         :id,
                         :method,
                         :exp_value,
                         :act_value,
                         :delta,
                         :epsilon,
                         :outcome,
                         :message,
                         :volatile,
                         :exception,
                     ])

    # This is redundant, but it helps RubyMine code inspection.
    attr_accessor \
        :act_value,
        :exp_value,
        :outcome,
        :volatile

    attr_accessor *FIELDS

    def initialize(file_path, xml_verdict)
      values = {
          :file_path => file_path,
      }
      # Stow the attributes.
      xml_verdict.attributes.each_pair do |name, attribute|
        field = name.to_sym
        value_s = attribute.to_s
        value = case
                  when [
                      :volatile,
                  ].include?(field)
                    value_s == 'true' ? true : false
                  when [
                      :method,
                      :outcome,
                  ].include?(field)
                    value_s.to_sym
                  else
                    value_s.to_s
                end
        values.store(name, value)
      end
      super(FIELDS, values)
      xml_verdict.children.each do |child|
        name = child.name
        # Exception needs to be an object.
        if  name == 'exception'
          self.exception = Verdict::Exception.new(child)
          next
        end
        # Others are simple values.
        value = child.text
        method = format('%s=', name)
        if self.respond_to?(method)
          send(method, value)
        else
          raise NotImplementedError.new(method)
        end
      end
    end

    def self.equal?(expected_obj, actual_obj)
      super(expected_obj, actual_obj, fields_to_ignore = [:file_path])
    end

    def path
      test_name = File.basename(file_path, '.xml')
      File.join(test_name, id)
    end

    class Exception < BaseClassForData

      include REXML

      FIELDS = Set.new([
                           :klass,
                           :message,
                           :backtrace,
                       ])

      attr_accessor *FIELDS

      # Constructor.
      Contract Nokogiri::XML::Element => nil
      def initialize(xml_exception)
        values = {}
        xml_exception.children.each do |child|
          field = child.name.to_sym
          field = :klass if field == :class
          value = child.text.to_s
          values.store(field, value)
        end
        super(FIELDS, values)
        nil
      end

      def to_html
        table_ele = Element.new('table')
        table_ele.add_attribute('border', '1')
        table_ele << tr_ele = Element.new('tr')
        tr_ele << th_ele = Element.new('th')
        th_ele << Text.new('Class')
        tr_ele << td_ele = Element.new('td')
        td_ele << Text.new(self.klass)
        # Message.
        table_ele << tr_ele = Element.new('tr')
        tr_ele << th_ele = Element.new('th')
        th_ele << Text.new('Message')
        tr_ele << td_ele = Element.new('td')
        td_ele << Text.new(self.message)
        # Backtrace.
        table_ele << tr_ele = Element.new('tr')
        tr_ele << th_ele = Element.new('th')
        th_ele << Text.new('Backtrace')
        tr_ele << td_ele = Element.new('td')
        td_ele << ol_ele = Element.new('ol')
        self.backtrace.split("\n").each do |line|
          ol_ele << li_ele = Element.new('li')
          ol_ele.add_attribute('start', '0')
          ol_ele.add_attribute('reversed', 'reversed')
          li_ele << Text.new(line)
        end
        table_ele
      end

    end

  end

  Contract String => HashOf[String, Verdict]
  def self.get_verdicts_from_directory(dir_path)
    file_paths = Dir.glob(File.join(dir_path, '*'))
    verdicts_by_path = {}
    file_paths.each do |file_path|
      new_verdicts_by_path = self.get_verdicts_from_file(file_path)
      verdicts_by_path.merge!(new_verdicts_by_path)
    end
    verdicts_by_path
  end

  Contract String => HashOf[String, Verdict]
  def self.get_verdicts_from_file(file_path)
    doc = Nokogiri::XML(File.open(file_path))
    xml_verdicts = doc.xpath('//verdict')
    verdicts_by_path = {}
    xml_verdicts.each do |xml_verdict|
      verdict = Verdict.new(file_path, xml_verdict)
      verdicts_by_path.store(verdict.path, verdict)
    end
    verdicts_by_path
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
    self.backtrace_filter = options[:backtrace_filter] || /log|ruby/
    self.file = File.open(self.file_path, 'w')
    log_puts("REMARK\tThis text log is the precursor for an XML log.")
    log_puts("REMARK\tIf the logged process completes, this text will be converted to XML.")
    log_puts("BEGIN\t#{self.root_name}")
    self.counts = Hash[
        :verdict => 0,
        :failure => 0,
        :error => 0,
    ]
    nil
  end

  def dispose

    puts 'Counts for %s:' % TestHelper.get_method_name
      self.counts.each_pair do |label, count|
      puts format('  %ss %s', label.to_s.capitalize.rjust(10), count.to_s.rjust(6))
    end

    # An error may have caused some blocked verdicts, but does not itself show up as a verdict.
    # Take a verdict here, so that an error will cause a :failed in the log.
    # The count is volatile, so it's not an error to differ from previous.
    section('Count of errors (unexpected exceptions)') do
      verdict_assert_equal?('error count', 0, self.counts[:error], 'error count', volatile = true)
    end

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
      outcome, exception = get_assertion_outcome(verdict_id, assertion_method, *args_hash.values) do
        yield
      end
    else
      outcome, exception = get_assertion_outcome(verdict_id, assertion_method, *args_hash.values)
    end
    element_attributes = {
        :method => verdict_method,
        :outcome => outcome,
        :id => verdict_id,
        :volatile => volatile,
        :message => message,
    }
    put_element('verdict', element_attributes, *args) do
      args_hash.each_pair do |k, v|
        put_element(k.to_s, v)
      end
      if exception
        self.counts[:failure] += 1
        put_element('exception') do
          put_element('class', exception.class)
          put_element('message', exception.message)
          put_element('backtrace') do
            cdata(filter_backtrace(exception.backtrace))
          end
        end
      end
    end
    outcome == :passed
  end

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

  Contract VERDICT_ID, Symbol, ARGS,  Maybe[Proc] => [Symbol, Maybe[Exception]]
  def get_assertion_outcome(verdict_id, assertion_method, *assertion_args)
    validate_verdict_id(verdict_id)
    self.counts[:verdict] += 1
    begin
      if block_given?
        send(assertion_method, *assertion_args) do
          yield
        end
      else
        send(assertion_method, *assertion_args)
      end
      return :passed, nil
    rescue Minitest::Assertion => x
      return :failed, x
    end
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
  def filter_backtrace(lines)
    filtered = ['']
    lines.each do |line|
      unless line.match(self.backtrace_filter)
        filtered.push(line)
      end
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
