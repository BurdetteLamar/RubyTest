require 'set'

require_relative 'common_requires'

# Class to test class +Log+.
class LogTest < MiniTest::Test

  include Contracts

  attr_accessor :test

  Contract MiniTest::Test, Proc => String
  # Create a temporary logfile.
  # Caller should provide a block to be executed using the log.
  # Returns the file path to the closed log.
  def create_temp_log(test)
    dir_path = Dir.mktmpdir
    file_path = File.join(dir_path, 'log.xml')
    Log.open(test, {:file_path => file_path}) do |log|
      yield log
    end
    file_path
  end

  # Helper class for checking logged output.
  class Checker

    include Contracts

    attr_accessor \
      :exceptions,
      :file_path,
      :root,
      :test,
      :verdicts

    Contract MiniTest::Test, String => nil
    # - +test+:  +MiniTest::Test+ object, to make assertions available.
    # - +file_path+:  Path to log file.
    def initialize(test, file_path)
      # Needs the test object for accessing assertions.
      self.test = test
      self.file_path = file_path
      # Clean up after.
      ObjectSpace.define_finalizer(self, method(:finalize))
      File.open(file_path, 'r') do |file|
        self.root = REXML::Document.new(file).root
        self.verdicts = {}
        REXML::XPath.match(root, '//verdict').each do |verdict|
          id = verdict.attributes.get_attribute('id').value.to_sym
          self.verdicts.store(id, verdict)
        end
        self.exceptions = match('//exception')
      end
      nil
    end

    Contract Num => nil
    # To clean up the temporary directory.
    # - +object_id+:  Id of temp directory.
    def finalize(object_id)
      file_path = ObjectSpace._id2ref(object_id).file_path
      File.delete(file_path)
      Dir.delete(File.dirname(file_path))
      nil
    end

    Contract Num => Bool
    # Verify the verdict count.
    def assert_verdict_count(expected_count)
      # The log itself gens one verdict.
      actual_count = self.verdicts.size - 1
      self.test.assert_equal(expected_count, actual_count, 'verdict count')
    end

    Contract Symbol, HashOf[Symbol, Any] => Bool
    # Verify verdict attributes.
    def assert_verdict_attributes(verdict_id, expected_attributes)
      verdict = verdicts.fetch(verdict_id)
      actual_attributes = {}
      verdict.attributes.each do |attribute|
        name, value = *attribute
        actual_attributes[name.to_sym] = value.to_s
      end
      expected_attributes.each_pair do |name, value|
        expected_attributes[name] = value.to_s unless value.kind_of?(Regexp)
      end
      self.test.assert_equal(Set.new(expected_attributes.keys), Set.new(actual_attributes.keys), 'keys')
      expected_attributes.each_pair do |key, expected_value|
        actual_value = actual_attributes[key]
        self.test.assert_match(expected_value, actual_value, key.to_s)
      end
      true
    end

    Contract Num => Bool
    # verify exception count.
    def assert_exception_count(expected_count)
      self.test.assert_equal(expected_count, self.exceptions.size, 'exception count')
    end

    Contract String, String, String => Bool
    # Verify text in element.
    def assert_element_text(ele_xpath, expected_value, message)
      actual_value = match(ele_xpath).first.text
      self.test.assert_match(expected_value, actual_value, message)
    end

    Contract String, String, String => Bool
    # Verify attribute value.
    def assert_attribute_value(ele_xpath, attr_name, expected_value)
      attr_xpath = format('%s/@%s', ele_xpath, attr_name)
      actual_value = match(attr_xpath).first.value
      self.test.assert_equal(expected_value, actual_value, attr_name)
    end

    Contract String => Array
    def match(xpath)
      REXML::XPath.match(root, xpath)
    end

  end

  Contract HashOf[Symbol, Any] => nil
  # Tests for (most) all verdict methods.
  def verdict_common_test(hash)

    # Hash arg has these three items.
    # The last two values are name/value pairs representing arguments
    # that should pass or fail.
    method = hash[:method]
    passing_arguments = hash[:passing_arguments]
    failing_arguments = hash[:failing_arguments]

    # Test with passing arguments.
    verdict_id = :passes
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      assert(log.send(method, verdict_id, *passing_arguments.values, message: verdict_id), message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)

    # Test with failing arguments.
    verdict_id = :fails
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=s', method, verdict_id, passing_arguments.inspect)
      assert(!log.send(method, verdict_id, *failing_arguments.values, message: verdict_id), message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

    # Test contract for verdict id.
    verdict_id = :contract_violation_for_verdict_id
    create_temp_log(self) do |log|
      assert_raises(ParamContractError, 'verdict id') do
        log.send(method, nil, *passing_arguments.values, message: verdict_id)
      end
    end

    # Test contract for message.
    verdict_id = :contract_violation_for_message
    create_temp_log(self) do |log|
      assert_raises(ParamContractError, 'message') do
        log.send(method, verdict_id, *passing_arguments.values)
      end
    end

    # Test contract for volatile.
    verdict_id = :contract_violation_for_volatile
    create_temp_log(self) do |log|
      assert_raises(ParamContractError, 'volatile') do
        log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: 0)
      end
    end

    # Test contract for the other arguments.
    argument_names = passing_arguments.keys.collect{ |key| key.to_s }
    argument_values = passing_arguments.values
    argument_names.each_with_index do |name, i|
      violating_values = argument_values.clone
      violating_values[i] = nil
      verdict_id = format('contract_violation_for_%s', name).to_sym
      create_temp_log(self) do |log|
        assert_raises(ParamContractError, name) do
          log.send(method, *violating_values, verdict_id, message: message)
        end
      end
    end
    nil
  end

  def test_new

    method = :new

    AssertionHelper.assert_raises_with_message(self, RuntimeError, Log::NO_NEW_MSG) do
      Log.new(self).send(method)
    end

  end

  def test_open

    method = :open

    # No block.
    AssertionHelper.assert_raises_with_message(self, RuntimeError, Log::NO_BLOCK_GIVEN_MSG) do
      Log.open(self).send(method)
    end

    # Block.
    dir_path = Dir.mktmpdir
    file_path = File.join(dir_path, 'log.xml')
    AssertionHelper.assert_nothing_raised(self) do
      Log.open(self, {:file_path => file_path}) do |log|
        log.put_element('foo')
      end
    end
    FileUtils.rm_r(dir_path)

  end

  def test_put_element
    # TODO.
  end

  def test_section

    method = :section

    # Contract violation for section name.
    create_temp_log(self) do |log|
      assert_raises(ParamContractError, 'section name') do
        log.send(method, nil)
      end
    end

    # Section names.
    file_path = create_temp_log(self) do |log|
      log.send(method, 'outer') do
        log.send(method, 'inner') do
          log.put_element('tag', 'text')
        end
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//section[@name='outer']/section[@name='inner']/tag"
    checker.assert_element_text(ele_xpath, 'text', 'nested section text')

    # TODO:  Test *args for section.

  end

  def test_verdict_assert

    method = :verdict_assert?

    # Use true/false.
    passing_arguments = {
        :actual => true,
    }
    failing_arguments = {
        :actual => false,
    }
    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

    # Use object/nil.
    passing_arguments = {
        :actual => String.new(''),
    }
    failing_arguments = {
        :actual => nil,
    }
    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute

    method = :verdict_refute?

    # Use false/true.
    passing_arguments = {
        :actual => false,
    }
    failing_arguments = {
        :actual => true,
    }
    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

    # Use nil/object.
    passing_arguments = {
        :actual => nil,
    }
    failing_arguments = {
        :actual => String.new(''),
    }
    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_empty

    method = :verdict_assert_empty?
    passing_arguments = {
        :actual => '',
    }
    failing_arguments = {
        :actual => 'foo',
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

    verdict_id = :no_empty_method_fails
    file_path = create_temp_log(self) do |log|
      verdict = log.send(method, verdict_id, 0, message: verdict_id)
      assert(!verdict, verdict_id)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

  def test_verdict_refute_empty

    method = :verdict_refute_empty?
    passing_arguments = {
        :actual => 'foo',
    }
    failing_arguments = {
        :actual => '',
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

    verdict_id = :no_empty_method_fails
    file_path = create_temp_log(self) do |log|
      verdict = log.send(method, verdict_id, 0, message: verdict_id)
      assert(!verdict, verdict_id)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

  def test_verdict_assert_equal

    method = :verdict_assert_equal?
    passing_arguments = {
        :expected => 0,
        :actual => 0,
    }
    failing_arguments = {
        :expected => 0,
        :actual => 1,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

    verdict_id = :hash_passes
    file_path = create_temp_log(self) do |log|
      assert(log.send(method, verdict_id, {:a => 0}, {:a => 0}, message: verdict_id), verdict_id)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)

    verdict_id = :set_passes
    file_path = create_temp_log(self) do |log|
      assert(log.send(method, verdict_id, Set.new([:a, :b]), Set.new([:b, :a]), message: verdict_id), verdict_id)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {

        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)

    verdict_id = :hash_fails
    file_path = create_temp_log(self) do |log|
      assert(!log.send(method, verdict_id,
                       {:a => 0, :c => 2, :d => 3},
                       {:b => 1, :c => 3, :d => 3},
                       message: verdict_id
             ), verdict_id)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_verdict_count(1)
    checker.assert_attribute_value('//analysis/missing', 'a', '0')
    checker.assert_attribute_value('//analysis/unexpected', 'b', '1')
    checker.assert_attribute_value('//analysis/changed', 'c', '{:expected=>2, :actual=>3}')
    checker.assert_attribute_value('//analysis/ok', 'd', '3')

    verdict_id = :set_fails
    file_path = create_temp_log(self) do |log|
      assert(!log.send(method, verdict_id,
                       Set.new([:a, :b]),
                       Set.new([:a, :c]),
                       message: verdict_id
             ), verdict_id)
    end
    checker = Checker.new(self, file_path)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_verdict_count(1)
    checker.assert_element_text('//analysis/missing', Set.new([:b]).inspect, 'missing')
    checker.assert_element_text('//analysis/unexpected', Set.new([:c]).inspect, 'unexpected')
    checker.assert_element_text('//analysis/ok', Set.new([:a]).inspect, 'ok')

    verdict_id = :different_types
    file_path = create_temp_log(self) do |log|
      assert(!log.send(method, verdict_id, 0, 'a', message: verdict_id), verdict_id)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

  def test_verdict_refute_equal

    method = :verdict_refute_equal?
    passing_arguments = {
        :expected => 0,
        :actual => 1,
    }
    failing_arguments = {
        :expected => 0,
        :actual => 0,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_in_delta

    method = :verdict_assert_in_delta?
    passing_arguments = {
        :expected => 0,
        :actual => 1,
        :delta => 1,
    }
    failing_arguments = {
        :expected => 0,
        :actual => 1,
        :delta => 0.1,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_in_delta

    method = :verdict_refute_in_delta?
    passing_arguments = {
        :expected => 0,
        :actual => 1,
        :delta => 0.11,
    }
    failing_arguments = {
        :expected => 0,
        :actual => 1,
        :delta => 1,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_in_epsilon

    method = :verdict_assert_in_epsilon?
    passing_arguments = {
        :expected => 0,
        :actual => 0,
        :delta => 1,
    }
    failing_arguments = {
        :expected => 0,
        :actual => 4,
        :delta => 1,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_in_epsilon

    method = :verdict_refute_in_epsilon?
    passing_arguments = {
        :expected => 0,
        :actual => 1,
        :delta => 0.1,
    }
    failing_arguments = {
        :expected => 0,
        :actual => 0,
        :delta => 1,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_includes

    method = :verdict_assert_includes?
    passing_arguments = {
        :expected => [0],
        :actual => 0,
    }
    failing_arguments = {
        :expected => [0],
        :actual => 1,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_includes

    method = :verdict_refute_includes?
    passing_arguments = {
        :expected => [0],
        :actual => 1,
    }
    failing_arguments = {
        :expected => [0],
        :actual => 0,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_instance_of

    method = :verdict_assert_instance_of?
    passing_arguments = {
        :expected => String,
        :actual => '',
    }
    failing_arguments = {
        :expected => String,
        :actual => 0,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_instance_of

    method = :verdict_refute_instance_of?
    passing_arguments = {
        :expected => String,
        :actual => 0,
    }
    failing_arguments = {
        :expected => String,
        :actual => '',
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_kind_of

    method = :verdict_assert_kind_of?
    passing_arguments = {
        :expected => Object,
        :actual => String,
    }
    failing_arguments = {
        :expected => String,
        :actual => 0,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_kind_of

    method = :verdict_refute_kind_of?
    passing_arguments = {
        :expected => String,
        :actual => 0,
    }
    failing_arguments = {
        :expected => Object,
        :actual => String,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_match

    method = :verdict_assert_match?
    passing_arguments = {
        :expected => %r/x/,
        :actual => 'x',
    }
    failing_arguments = {
        :expected => %r/x/,
        :actual => 'y',
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_match

    method = :verdict_refute_match?
    passing_arguments = {
        :expected => %r/x/,
        :actual => 'y',
    }
    failing_arguments = {
        :expected => %r/x/,
        :actual => 'x',
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_nil

    method = :verdict_assert_nil?
    passing_arguments = {
        :actual => nil,
    }
    failing_arguments = {
        :actual => true,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_nil

    method = :verdict_refute_nil?
    passing_arguments = {
        :actual => true,
    }
    failing_arguments = {
        :actual => nil,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_operator

    method = :verdict_assert_operator?
    passing_arguments = {
        :object_0 => 1,
        :operator => :<,
        :object_1 => 2,
    }
    failing_arguments = {
        :object_0 => 1,
        :operator => :>,
        :object_1 => 2,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_operator

    method = :verdict_refute_operator?
    passing_arguments = {
        :object_0 => 1,
        :operator => :>,
        :object_1 => 2,
    }
    failing_arguments = {
        :object_0 => 1,
        :operator => :<,
        :object_1 => 2,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_output

    method = :verdict_assert_output?
    passing_arguments = {
        :stdout => 'stdout',
        :stderr => 'stderr',
    }
    failing_arguments = {
        :stdout => 'not stdout',
        :stderr => 'not stderr',
    }
    # Test with passing arguments.
    verdict_id = :passes
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      verdict = log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: false) do
        $stdout.print(passing_arguments[:stdout])
        $stderr.print(passing_arguments[:stderr])
      end
      assert(verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)
    # Test with failing arguments.
    verdict_id = :fails
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      verdict = log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: false) do
        $stdout.print(failing_arguments[:stdout])
        $stderr.print(failing_arguments[:stderr])
      end
      assert(!verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

  # Minitest::Assertion does not have :refute_output, so we don't have :verdict_refute_output?.

  def test_verdict_assert_predicate

    method = :verdict_assert_predicate?
    passing_arguments = {
        :object => '',
        :predicate => :empty?
    }
    failing_arguments = {
        :object => 'foo',
        :predicate => :empty?
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_predicate

    method = :verdict_refute_predicate?
    passing_arguments = {
        :object => 'foo',
        :predicate => :empty?
    }
    failing_arguments = {
        :object => '',
        :predicate => :empty?
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_raises

    method = :verdict_assert_raises?
    passing_arguments = {
        :passes => RuntimeError,
    }
    failing_arguments = {
        :fails => NotImplementedError
    }
    # Test with passing arguments.
    verdict_id = :passes
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      verdict = log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: false) do
        raise passing_arguments[:passes].new('Boo!')
      end
      assert(verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)
    # Test with failing arguments.
    verdict_id = :fails
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      verdict = log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: false) do
        raise failing_arguments[:fails].new('Boo!')
      end
      assert(!verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

  # Minitest::Assertion does not have :refute_raises, so we don't have :verdict_refute_raises?.

  def test_verdict_assert_respond_to

    method = :verdict_assert_respond_to?
    passing_arguments = {
        :object => '',
        :method => :empty?
    }
    failing_arguments = {
        :object => 0,
        :method => :empty?
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_respond_to

    method = :verdict_refute_respond_to?
    passing_arguments = {
        :object => 0,
        :method => :empty?
    }
    failing_arguments = {
        :object => '',
        :method => :empty?
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_assert_same

    method = :verdict_assert_same?
    passing_arguments = {
        :expected => :same,
        :actual => :same,
    }
    failing_arguments = {
        :expected => :same,
        :actual => :different,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  def test_verdict_refute_same

    method = :verdict_refute_same?
    passing_arguments = {
        :expected => :same,
        :actual => :different,
    }
    failing_arguments = {
        :expected => :same,
        :actual => :same,
    }

    verdict_common_test(
        :method => method,
        :passing_arguments => passing_arguments,
        :failing_arguments => failing_arguments,
    ) 

  end

  # Minitest::Assertion treats method :assert_send as deprecated, so we don't have :verdict_assert_send.

  # Minitest::Assertion does not have :refute_send, so we don't have :verdict_refute_send?.

  def test_verdict_silent

    method = :verdict_assert_silent?
    # Test with passing arguments.
    verdict_id = :passes
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s', method, verdict_id)
      verdict = log.send(method, verdict_id, message: verdict_id, volatile: false) do
      end
      assert(verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)
    # Test with failing arguments.
    verdict_id = :fails
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s', method, verdict_id)
      verdict = log.send(method, verdict_id, message: verdict_id, volatile: false) do
        $stdout.print('Boo!')
        $stderr.print('Boo!')
      end
      assert(!verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

  # Minitest::Assertion does not have :refute_silent, so we don't have :verdict_refute_silent?.

  def test_verdict_throws

    method = :verdict_assert_throws?
    passing_arguments = {
        :passes => Exception,
    }
    failing_arguments = {
        :fails => NotImplementedError
    }
    # Test with passing arguments.
    verdict_id = :passes
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      verdict = log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: false) do
        throw passing_arguments[:passes]
      end
      assert(verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'passed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(0)
    # Test with failing arguments.
    verdict_id = :fails
    file_path = create_temp_log(self) do |log|
      message = format('Method=%s; verdict_id=%s; data=%s', method, verdict_id, passing_arguments.inspect)
      verdict = log.send(method, verdict_id, *passing_arguments.values, message: verdict_id, volatile: false) do
        throw failing_arguments[:fails]
      end
      assert(!verdict, message: message)
    end
    checker = Checker.new(self, file_path)
    checker.assert_verdict_count(1)
    attributes = {
        :id => verdict_id,
        :method => method,
        :outcome => 'failed',
        :message => verdict_id,
        :volatile => false,
    }
    checker.assert_verdict_attributes(verdict_id, attributes)
    checker.assert_exception_count(1)

  end

end
