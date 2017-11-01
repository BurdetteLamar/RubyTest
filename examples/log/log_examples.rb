require 'set'

require_relative '../../test/common_requires'
require_relative '../../lib/helpers/test_helper'

# Class to show how to use the Log object.
class LogExamples < MiniTest::Test

  # This is just a caller for the other, specific, example methods.
  def test_log_examples

    open_examples

    @log_dir_path = TestHelper.create_app_log_dir('log')

    def self.open_log(method)
      file_name = format('%s.xml', method)
      file_path = File.join(
                          @log_dir_path,
                          file_name,
      )
      Log.open(self, :file_path => file_path) do |log|
        yield log
      end
    end

    section_examples
    put_element_examples

    verdict_assert_examples
    verdict_assert_empty_examples
    verdict_assert_equal_examples
    verdict_assert_in_delta_examples
    verdict_assert_in_epsilon_examples
    verdict_assert_includes_examples
    verdict_assert_instance_of_examples
    verdict_assert_kind_of_examples
    verdict_assert_match_examples
    verdict_assert_nil_examples
    verdict_assert_operator_examples
    verdict_assert_output_examples
    verdict_assert_predicate_examples
    verdict_assert_raises_examples
    verdict_assert_respond_to_examples
    verdict_assert_same_examples
    verdict_assert_silent_examples
    verdict_assert_throws_examples

    verdict_refute_examples
    verdict_refute_empty_examples
    verdict_refute_equal_examples
    verdict_refute_in_delta_examples
    verdict_refute_in_epsilon_examples
    verdict_refute_includes_examples
    verdict_refute_instance_of_examples
    verdict_refute_kind_of_examples
    verdict_refute_match_examples
    verdict_refute_nil_examples
    verdict_refute_operator_examples
    verdict_refute_predicate_examples
    verdict_refute_respond_to_examples
    verdict_refute_same_examples

    puts 'The example logs may be seen at %s.' % File.absolute_path(@log_dir_path)

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show method +Log.open+.
  #
  # The first argument must be an instance of Minitest::Test.
  # The second argument is optional, and may specify options, as shown here.
  #
  # We've used a temporary directory for this because there's little need to see the created log.
  def open_examples
    dir_path = Dir.mktmpdir
    file_path = File.join(dir_path, 'log.xml')
    options = {
        :file_path => file_path, # defaults to ''./log.xml'
        :root_name => 'my_log', # defaults to 'log'
        :xml_indentation => 2, # defaults to -1 (all on one line)
    }
    Log.open(self, options) do |_|
    end
    File.delete(file_path)
    Dir.delete(File.dirname(file_path))
  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show method +section+:
  #
  # - With nested sections.
  # - With +:timestamp+, +:duration+, and +:rescue+.
  # - With custom attributes.
  #
  # You can also pass other objects in *+args+,
  # and they will be rendered into the PCDATA for the section element.
  def section_examples

    self.open_log(__method__) do |log|

      log.section('Section examples') do

        # Nested sections.
        log.section('Outer section') do
          log.section('Inner section') do
            # More logging can go here.
          end
        end

        log.section('With timestamp', :timestamp) do
          # More logging can go here.
        end

        log.section('With duration', :duration) do
          sleep(1.5)
        end

        log.section('With rescue', :rescue) do
          raise RuntimeError.new('Boo!')
        end

        log.section('With custom attributes', {:attr_name_0 => 'attr_value_0', :attr_name_1 => 'attr_value_1'}) do
          # More logging can go here.
        end

      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show method +put_element+:
  #
  # - With string arguments.
  # - With other arguments.
  # - With mixture of arguments.
  #
  # You can also pass +:duration+, +:timestamp+, and +:rescue+ to put_element,
  # but that will usually not make much sense.
  def put_element_examples

    self.open_log(__method__) do |log|

      log.section('Put element examples') do

        log.section('Put element with strings, which are appended to PCDATA') do
          log.put_element('strings', 'First string.', 'Second string.')
        end

        log.section('Put element with objects, whose .inspect values are appended to PCDATA') do
          log.put_element('objects', Set.new([:a, :b]), Float(3.14159))
        end

        log.section('Put element with mix of arguments') do
          log.put_element('mixture', 'First string.', Set.new([:a, :b]), 'Second string', Float(3.14159))
        end

      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert? passing, failing, and with volatile: true.
  # - Alias va? passing, failing, and with volatile: true.
  def verdict_assert_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert?') do
        log.verdict_assert?(:passing_verdict_assert, actual = true, message: 'Passing verdict_assert?')
        log.verdict_assert?(:failing_verdict_assert, actual = false, message: 'Failing verdict_assert?')
        log.verdict_assert?(:volatile_verdict_assert, actual = true, message: 'Volatile verdict_assert?', volatile: true)
      end

      log.section('Use alias va?') do
        log.va?(:passing_va, actual = true, message: 'Passing va?')
        log.va?(:failing_va, actual = false, message: 'Failing va?')
        log.va?(:volatile_va, actual = true, message: 'Volatile va?', volatile: true)
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_empty? passing and failing
  # - Alias va_empty? passing and failing.
  def verdict_assert_empty_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_empty?') do
        log.verdict_assert_empty?(:passing_verdict_assert_empty, actual = [], message: 'Passing verdict_assert_empty?')
        log.verdict_assert_empty?(:failing_verdict_assert_empty, actual = [:a], message: 'Failing verdict_assert_empty?')
      end

      log.section('Use alias va_empty?') do
        log.va_empty?(:passing_va_empty, actual = [], message: 'Passing va_empty?')
        log.va_empty?(:failing_va_empty, actual = [:a], message: 'Failing va_empty?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_equal? passing and failing.
  # - Method verdict_assert_equal? with sets and hashes.
  #
  # - Alias va_equal? passing and failing.
  # - Alias va_equal? with sets and hashes.
  #
  # Failure for a set or hash puts detailed analysis into the log.
  def verdict_assert_equal_examples

    self.open_log(__method__) do |log|

      # Differing sets are analyzed in the log:  ok, missing, unexpected.
      expected_set = Set.new([:a, :b, :c, :d])
      actual_set = Set.new([:a, :b, :e, :f])

      # Differing hashes are analyzed in the log:  ok, missing, unexpected, changed.
      expected_hash = {
          :a => 0,
          :b => 1,
          :c => 2,
          :d => 3,
          :e => 4,
          :f => 5,
      }
      actual_hash = {
          :a => 0,
          :b => 1,
          :c => 3,
          :d => 2,
          :g => 6,
          :h => 7,
      }

      log.section('Use verdict_assert_equal?') do
        log.verdict_assert_equal?(:passing_verdict_assert_equal, 0, 0, message: 'Passing verdict_assert_equal?')
        log.verdict_assert_equal?(:failing_verdict_assert_equal, 0, 1, message: 'Failing verdict_assert_equal?')
        log.verdict_assert_equal?(:verdict_assert_equal_set, expected_set, actual_set, message: 'Sets')
        log.verdict_assert_equal?(:verdict_assert_equal_hash, expected_hash, actual_hash, message: 'Hashes')
      end

      log.section('Use va_equal?') do
        log.va_equal?(:passing_va_equal, 0, 0, message: 'Passing va_equal?')
        log.va_equal?(:failing_va_equal, 0, 1, message: 'Failing va_equal?')
        log.va_equal?(:va_equal_set, expected_set, actual_set, message: 'Sets')
        log.va_equal?(:va_equal_hash, expected_hash, actual_hash, message: 'Hashes')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_in_delta? passing and failing.
  # - Alias va_in_delta? passing and failing.
  def verdict_assert_in_delta_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_in_delta?') do
        log.verdict_assert_in_delta?(:passing_verdict_assert_in_delta, 1, 1.1, 0.2, message: 'Passing verdict_assert_in_delta?')
        log.verdict_assert_in_delta?(:failing_verdict_assert_in_delta, 1, 1.2, 0.1, message: 'Failing verdict_assert_in_delta?')
      end

      log.section('Use va_in_delta?') do
        log.va_in_delta?(:passing_va_in_delta, 1, 1.1, 0.2, message: 'Passing va_in_delta?')
        log.va_in_delta?(:failing_va_in_delta, 1, 1.2, 0.1, message: 'Failing va_in_delta?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_in_epsilon? passing and failing.
  # - Alias va_in_epsilon? passing and failing.
  def verdict_assert_in_epsilon_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_in_epsilon?') do
        log.verdict_assert_in_epsilon?(:passing_verdict_assert_in_epsilon, 1, 1.1, 0.2, message: 'Passing verdict_assert_in_epsilon?')
        log.verdict_assert_in_epsilon?(:failing_verdict_assert_in_epsilon, 1, 1.2, 0.1, message: 'Failing verdict_assert_in_epsilon?')
      end

      log.section('Use va_in_epsilon?') do
        log.va_in_epsilon?(:passing_va_in_epsilon, 1, 1.1, 0.2, message: 'Passing va_in_epsilon?')
        log.va_in_epsilon?(:failing_va_in_epsilon, 1, 1.2, 0.1, message: 'Failing va_in_epsilon?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_includes? passing and failing.
  #
  # - Alias va_includes? passing and failing.
  #
  def verdict_assert_includes_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_includes?') do
        log.verdict_assert_includes?(:passing_verdict_assert_includes, [:a], :a, message: 'Passing verdict_assert_includes?')
        log.verdict_assert_includes?(:failing_verdict_assert_includes, [:b], :a, message: 'Failing verdict_assert_includes?')
      end

      log.section('Use va_includes?') do
        log.va_includes?(:passing_va_includes, [:a], :a, message: 'Passing va_includes?')
        log.va_includes?(:failing_va_includes, [:b], :a, message: 'Failing va_includes?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_instance_of? passing and failing.
  #
  # - Alias va_instance_of? passing and failing.
  #
  def verdict_assert_instance_of_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_instance_of?') do
        log.verdict_assert_instance_of?(:passing_verdict_assert_instance_of, String, 'Boo!', message: 'Passing verdict_assert_instance_of?')
        log.verdict_assert_instance_of?(:failing_verdict_assert_instance_of, String, 0, message: 'Failing verdict_assert_instance_of?')
      end

      log.section('Use va_instance_of?') do
        log.va_instance_of?(:passing_va_instance_of, String, 'Boo!', message: 'Passing va_instance_of?')
        log.va_instance_of?(:failing_va_instance_of, String, 0, message: 'Failing va_instance_of?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_kind_of? passing and failing.
  #
  # - Alias va_kind_of? passing and failing.
  #
  def verdict_assert_kind_of_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_kind_of?') do
        log.verdict_assert_kind_of?(:passing_verdict_assert_kind_of, StandardError, RuntimeError.new, message: 'Passing verdict_assert_kind_of?')
        log.verdict_assert_kind_of?(:failing_verdict_assert_kind_of, StandardError, 0, message: 'Failing verdict_assert_kind_of?')
      end

      log.section('Use va_kind_of?') do
        log.va_kind_of?(:passing_va_kind_of, StandardError, RuntimeError.new, message: 'Passing va_kind_of?')
        log.va_kind_of?(:failing_va_kind_of, StandardError, 0, message: 'Failing va_kind_of?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_match? passing and failing.
  #
  # - Alias va_match? passing and failing.
  #
  def verdict_assert_match_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_match?') do
        log.verdict_assert_match?(:passing_verdict_assert_match, /foo/, 'food', message: 'Passing verdict_assert_match?')
        log.verdict_assert_match?(:failing_verdict_assert_match, /foo/, 'good', message: 'Failing verdict_assert_match?')
      end

      log.section('Use va_match?') do
        log.va_match?(:passing_va_match, /foo/, 'food', message: 'Passing va_match?')
        log.va_match?(:failing_va_match, /foo/, 'good', message: 'Failing va_match?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_nil? passing and failing
  # - Alias va_nil? passing and failing.
  def verdict_assert_nil_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_nil?') do
        log.verdict_assert_nil?(:passing_verdict_assert_nil, actual = nil, message: 'Passing verdict_assert_nil?')
        log.verdict_assert_nil?(:failing_verdict_assert_nil, actual = false, message: 'Failing verdict_assert_nil?')
      end

      log.section('Use alias va_nil?') do
        log.va_nil?(:passing_va_nil, actual = nil, message: 'Passing va_nil?')
        log.va_nil?(:failing_va_nil, actual = false, message: 'Failing va_nil?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_operator? passing and failing.
  # - Alias va_operator? passing and failing.
  def verdict_assert_operator_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_operator?') do
        log.verdict_assert_operator?(:passing_verdict_assert_operator, 1, :<, 2, message: 'Passing verdict_assert_operator?')
        log.verdict_assert_operator?(:failing_verdict_assert_operator, 2, :<, 1, message: 'Failing verdict_assert_operator?')
      end

      log.section('Use va_operator?') do
        log.va_operator?(:passing_va_operator, 1, :<, 2, message: 'Passing va_operator?')
        log.va_operator?(:failing_va_operator, 2, :<, 1, message: 'Failing va_operator?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_output? passing and failing.
  # - Alias va_output? passing and failing.
  def verdict_assert_output_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_output?') do
        log.verdict_assert_output?(:passing_verdict_assert_output, 'stdout', 'stderr', message: 'Passing verdict_assert_output?', volatile: false) do
          $stdout.print('stdout')
          $stderr.print('stderr')
        end
        log.verdict_assert_output?(:failing_verdict_assert_output, 'stdout', 'stderr', message: 'Failing verdict_assert_output?', volatile: false) do
          $stdout.print('not stdout')
          $stderr.print('not stderr')
        end

      end

      log.section('Use va_output?') do
        log.va_output?(:passing_va_output, 'stdout', 'stderr', message: 'Passing va_output?', volatile: false) do
          $stdout.print('stdout')
          $stderr.print('stderr')
        end
        log.va_output?(:failing_va_output, 'stdout', 'stderr', message: 'Failing va_output?', volatile: false) do
          $stdout.print('not stdout')
          $stderr.print('not stderr')
        end
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_predicate? passing and failing
  # - Alias va_predicate? passing and failing.
  def verdict_assert_predicate_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_predicate?') do
        log.verdict_assert_predicate?(:passing_verdict_assert_predicate, '', :empty?, message: 'Passing verdict_assert_predicate?')
        log.verdict_assert_predicate?(:failing_verdict_assert_predicate, 'a', :empty?, message: 'Failing verdict_assert_predicate?')
      end

      log.section('Use alias va_predicate?') do
        log.va_predicate?(:passing_va_predicate, '', :empty?, message: 'Passing va_predicate?')
        log.va_predicate?(:failing_va_predicate, 'a', :empty?, message: 'Failing va_predicate?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_raises? passing and failing.
  # - Alias va_raises? passing and failing.
  def verdict_assert_raises_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_raises?') do
        log.verdict_assert_raises?(:passing_verdict_assert_raises, RuntimeError, message: 'Passing verdict_assert_raises?', volatile: false) do
          raise RuntimeError.new('Boo!')
        end
        log.verdict_assert_raises?(:failing_verdict_assert_raises, RuntimeError, message: 'Failing verdict_assert_raises?', volatile: false) do
          # Nothing.
        end

      end

      log.section('Use va_raises?') do
        log.va_raises?(:passing_va_raises, RuntimeError, message: 'Passing va_raises?', volatile: false) do
          raise RuntimeError.new('Boo!')
        end
        log.va_raises?(:failing_va_raises, RuntimeError, message: 'Failing va_raises?', volatile: false) do
          # Nothing.
        end
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_respond_to? passing and failing
  # - Alias va_respond_to? passing and failing.
  def verdict_assert_respond_to_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_respond_to?') do
        log.verdict_assert_respond_to?(:passing_verdict_assert_respond_to, 'foo', :empty?, message: 'Passing verdict_assert_respond_to?')
        log.verdict_assert_respond_to?(:failing_verdict_assert_respond_to, 0, :empty?, message: 'Failing verdict_assert_respond_to?')
      end

      log.section('Use alias va_respond_to?') do
        log.va_respond_to?(:passing_va_respond_to, 'foo', :empty?, message: 'Passing va_respond_to?')
        log.va_respond_to?(:failing_va_respond_to, 0, :empty?, message: 'Failing va_respond_to?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_same? passing and failing.
  #
  # - Alias va_same? passing and failing.
  #
  def verdict_assert_same_examples

    self.open_log(__method__) do |log|

      object = Object.new
      different_object = Object.new

      log.section('Use verdict_assert_same?') do
        log.verdict_assert_same?(:passing_verdict_assert_same, object, object, message: 'Passing verdict_assert_same?')
        log.verdict_assert_same?(:failing_verdict_assert_same, object, different_object, message: 'Failing verdict_assert_same?')
      end

      log.section('Use va_same?') do
        log.va_same?(:passing_va_same, object, object, message: 'Passing va_same?')
        log.va_same?(:failing_va_same, object, different_object, message: 'Failing va_same?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_silent? passing and failing.
  # - Alias va_silent? passing and failing.
  def verdict_assert_silent_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_silent?') do
        log.verdict_assert_silent?(:passing_verdict_assert_silent, message: 'Passing verdict_assert_silent?', volatile: false) do
          # Remain silent.
        end
        log.verdict_assert_silent?(:failing_verdict_assert_silent, message: 'Failing verdict_assert_silent?', volatile: false) do
          $stdout.print('Boo!')
        end

      end

      log.section('Use va_silent?') do
        log.va_silent?(:passing_va_silent, message: 'Passing va_silent?', volatile: false) do
          # Remain silent.
        end
        log.va_silent?(:failing_va_silent, message: 'Failing va_silent?', volatile: false) do
          $stdout.print('Boo!')
        end
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_assert_throws? passing and failing.
  # - Alias va_throws? passing and failing.
  def verdict_assert_throws_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_assert_throws?') do
        log.verdict_assert_throws?(:passing_verdict_assert_throws, Exception, message: 'Passing verdict_assert_throws?', volatile: false) do
          throw Exception
        end
        log.verdict_assert_throws?(:failing_verdict_assert_throws, Exception, message: 'Failing verdict_assert_throws?', volatile: false) do
          # Nothing.
        end

      end

      log.section('Use va_throws?') do
        log.va_throws?(:passing_va_throws, Exception, message: 'Passing va_throws?', volatile: false) do
          throw Exception
        end
        log.va_throws?(:failing_va_throws, Exception, message: 'Failing va_throws?', volatile: false) do
          # Nothing.
        end
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute? passing, failing, and with volatile: true.
  # - Alias vr? passing, failing, and with volatile: true.
  def verdict_refute_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute?') do
        log.verdict_refute?(:passing_verdict_refute, actual = true, message: 'Passing verdict_refute?')
        log.verdict_refute?(:failing_verdict_refute, actual = false, message: 'Failing verdict_refute?')
        log.verdict_refute?(:volatile_verdict_refute, actual = true, message: 'Volatile verdict_refute?', volatile: true)
      end

      log.section('Use alias vr?') do
        log.vr?(:passing_vr, actual = true, message: 'Passing vr?')
        log.vr?(:failing_vr, actual = false, message: 'Failing vr?')
        log.vr?(:volatile_vr, actual = true, message: 'Volatile vr?', volatile: true)
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_empty? passing and failing
  # - Alias vr_empty? passing and failing.
  def verdict_refute_empty_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_empty?') do
        log.verdict_refute_empty?(:passing_verdict_refute_empty, actual = [:a], message: 'Passing verdict_refute_empty?')
        log.verdict_refute_empty?(:failing_verdict_refute_empty, actual = [], message: 'Failing verdict_refute_empty?')
      end

      log.section('Use alias vr_empty?') do
        log.vr_empty?(:passing_vr_empty, actual = [:a], message: 'Passing vr_empty?')
        log.vr_empty?(:failing_vr_empty, actual = [], message: 'Failing vr_empty?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_equal? passing and failing.
  #
  # - Alias vr_equal? passing and failing.
  def verdict_refute_equal_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_equal?') do
        log.verdict_refute_equal?(:passing_verdict_refute_equal, 0, 1, message: 'Passing verdict_refute_equal?')
        log.verdict_refute_equal?(:failing_verdict_refute_equal, 0, 0, message: 'Failing verdict_refute_equal?')
      end

      log.section('Use vr_equal?') do
        log.vr_equal?(:passing_vr_equal, 0, 1, message: 'Passing vr_equal?')
        log.vr_equal?(:failing_vr_equal, 0, 0, message: 'Failing vr_equal?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_in_delta? passing and failing.
  # - Alias vr_in_delta? passing and failing.
  def verdict_refute_in_delta_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_in_delta?') do
        log.verdict_refute_in_delta?(:passing_verdict_refute_in_delta, 1, 1.1, 0.2, message: 'Passing verdict_refute_in_delta?')
        log.verdict_refute_in_delta?(:failing_verdict_refute_in_delta, 1, 1.2, 0.1, message: 'Failing verdict_refute_in_delta?')
      end

      log.section('Use vr_in_delta?') do
        log.vr_in_delta?(:passing_vr_in_delta, 1, 1.2, 0.1, message: 'Passing vr_in_delta?')
        log.vr_in_delta?(:failing_vr_in_delta, 1, 1.1, 0.2, message: 'Failing vr_in_delta?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_in_epsilon? passing and failing.
  # - Alias vr_in_epsilon? passing and failing.
  def verdict_refute_in_epsilon_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_in_epsilon?') do
        log.verdict_refute_in_epsilon?(:passing_verdict_refute_in_epsilon, 1, 1.2, 0.1, message: 'Passing verdict_refute_in_epsilon?')
        log.verdict_refute_in_epsilon?(:failing_verdict_refute_in_epsilon, 1, 1.1, 0.2, message: 'Failing verdict_refute_in_epsilon?')
      end

      log.section('Use vr_in_epsilon?') do
        log.vr_in_epsilon?(:passing_vr_in_epsilon, 1, 1.2, 0.1, message: 'Passing vr_in_epsilon?')
        log.vr_in_epsilon?(:failing_vr_in_epsilon, 1, 1.1, 0.2, message: 'Failing vr_in_epsilon?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_includes? passing and failing.
  #
  # - Alias vr_includes? passing and failing.
  #
  def verdict_refute_includes_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_includes?') do
        log.verdict_refute_includes?(:passing_verdict_refute_includes, [:b], :a, message: 'Passing verdict_refute_includes?')
        log.verdict_refute_includes?(:failing_verdict_refute_includes, [:a], :a, message: 'Failing verdict_refute_includes?')
      end

      log.section('Use vr_includes?') do
        log.vr_includes?(:passing_vr_includes, [:b], :a, message: 'Passing vr_includes?')
        log.vr_includes?(:failing_vr_includes, [:a], :a, message: 'Failing vr_includes?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_instance_of? passing and failing.
  #
  # - Alias vr_instance_of? passing and failing.
  #
  def verdict_refute_instance_of_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_instance_of?') do
        log.verdict_refute_instance_of?(:passing_verdict_refute_instance_of, String, 0, message: 'Passing verdict_refute_instance_of?')
        log.verdict_refute_instance_of?(:failing_verdict_refute_instance_of, String, 'Boo!', message: 'Failing verdict_refute_instance_of?')
      end

      log.section('Use vr_instance_of?') do
        log.vr_instance_of?(:passing_vr_instance_of, String, 0, message: 'Passing vr_instance_of?')
        log.vr_instance_of?(:failing_vr_instance_of, String, 'Boo!', message: 'Failing vr_instance_of?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_kind_of? passing and failing.
  #
  # - Alias vr_kind_of? passing and failing.
  #
  def verdict_refute_kind_of_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_kind_of?') do
        log.verdict_refute_kind_of?(:passing_verdict_refute_kind_of, StandardError, 0, message: 'Passing verdict_refute_kind_of?')
        log.verdict_refute_kind_of?(:failing_verdict_refute_kind_of, StandardError, RuntimeError.new, message: 'Failing verdict_refute_kind_of?')
      end

      log.section('Use vr_kind_of?') do
        log.vr_kind_of?(:passing_vr_kind_of, StandardError, 0, message: 'Passing vr_kind_of?')
        log.vr_kind_of?(:failing_vr_kind_of, StandardError, RuntimeError.new, message: 'Failing vr_kind_of?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_match? passing and failing.
  #
  # - Alias vr_match? passing and failing.
  #
  def verdict_refute_match_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_match?') do
        log.verdict_refute_match?(:passing_verdict_refute_match, /foo/, 'good', message: 'Passing verdict_refute_match?')
        log.verdict_refute_match?(:failing_verdict_refute_match, /foo/, 'food', message: 'Failing verdict_refute_match?')
      end

      log.section('Use vr_match?') do
        log.vr_match?(:passing_vr_match, /foo/, 'good', message: 'Passing vr_match?')
        log.vr_match?(:failing_vr_match, /foo/, 'food', message: 'Failing vr_match?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_nil? passing and failing
  # - Alias vr_nil? passing and failing.
  def verdict_refute_nil_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_nil?') do
        log.verdict_refute_nil?(:passing_verdict_refute_nil, actual = false, message: 'Passing verdict_refute_nil?')
        log.verdict_refute_nil?(:failing_verdict_refute_nil, actual = nil, message: 'Failing verdict_refute_nil?')
      end

      log.section('Use alias vr_nil?') do
        log.vr_nil?(:passing_vr_nil, actual = false, message: 'Passing vr_nil?')
        log.vr_nil?(:failing_vr_nil, actual = nil, message: 'Failing vr_nil?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_operator? passing and failing.
  # - Alias vr_operator? passing and failing.
  def verdict_refute_operator_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_operator?') do
        log.verdict_refute_operator?(:passing_verdict_refute_operator, 1, :>, 2, message: 'Passing verdict_refute_operator?')
        log.verdict_refute_operator?(:failing_verdict_refute_operator, 2, :>, 1, message: 'Failing verdict_refute_operator?')
      end

      log.section('Use vr_operator?') do
        log.vr_operator?(:passing_vr_operator, 1, :>, 2, message: 'Passing vr_operator?')
        log.vr_operator?(:failing_vr_operator, 2, :>, 1, message: 'Failing vr_operator?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_predicate? passing and failing
  # - Alias vr_predicate? passing and failing.
  def verdict_refute_predicate_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_predicate?') do
        log.verdict_refute_predicate?(:passing_verdict_refute_predicate, 'a', :empty?, message: 'Passing verdict_refute_predicate?')
        log.verdict_refute_predicate?(:failing_verdict_refute_predicate, '', :empty?, message: 'Failing verdict_refute_predicate?')
      end

      log.section('Use alias vr_predicate?') do
        log.vr_predicate?(:passing_vr_predicate, 'a', :empty?, message: 'Passing vr_predicate?')
        log.vr_predicate?(:failing_vr_predicate, '', :empty?, message: 'Failing vr_predicate?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_respond_to? passing and failing
  # - Alias vr_respond_to? passing and failing.
  def verdict_refute_respond_to_examples

    self.open_log(__method__) do |log|

      log.section('Use verdict_refute_respond_to?') do
        log.verdict_refute_respond_to?(:passing_verdict_refute_respond_to, 0, :empty?, message: 'Passing verdict_refute_respond_to?')
        log.verdict_refute_respond_to?(:failing_verdict_refute_respond_to, 'foo', :empty?, message: 'Failing verdict_refute_respond_to?')
      end

      log.section('Use alias vr_respond_to?') do
        log.vr_respond_to?(:passing_vr_respond_to, 0, :empty?, message: 'Passing vr_respond_to?')
        log.vr_respond_to?(:failing_vr_respond_to, 'foo', :empty?, message: 'Failing vr_respond_to?')
      end

    end

  end

  # <em>In the Rdoc, click the method name to toggle source.</em>
  #
  # Here we show:
  #
  # - Method verdict_refute_same? passing and failing.
  #
  # - Alias vr_same? passing and failing.
  #
  def verdict_refute_same_examples

    self.open_log(__method__) do |log|

      object = Object.new
      different_object = Object.new

      log.section('Use verdict_refute_same?') do
        log.verdict_refute_same?(:passing_verdict_refute_same, object, different_object, message: 'Passing verdict_refute_same?')
        log.verdict_refute_same?(:failing_verdict_refute_same, object, object, message: 'Failing verdict_refute_same?')
      end

      log.section('Use vr_same?') do
        log.vr_same?(:passing_vr_same, object, different_object, message: 'Passing vr_same?')
        log.vr_same?(:failing_vr_same, object, object, message: 'Failing vr_same?')
      end

    end

  end

end
