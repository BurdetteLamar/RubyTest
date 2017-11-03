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
        log.verdict_assert?(:passing_verdict_assert, actual = true)
        log.verdict_assert?(:failing_verdict_assert, actual = false)
        log.verdict_assert?(:volatile_verdict_assert, actual = true, volatile = true)
      end

      log.section('Use alias va?') do
        log.va?(:passing_va, actual = true)
        log.va?(:failing_va, actual = false)
        log.va?(:volatile_va, actual = true, 'Volatile va?')
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
        log.verdict_assert_empty?(:passing_verdict_assert_empty, actual = [])
        log.verdict_assert_empty?(:failing_verdict_assert_empty, actual = [:a])
      end

      log.section('Use alias va_empty?') do
        log.va_empty?(:passing_va_empty, actual = [])
        log.va_empty?(:failing_va_empty, actual = [:a])
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
        log.verdict_assert_equal?(:passing_verdict_assert_equal, 0, 0)
        log.verdict_assert_equal?(:failing_verdict_assert_equal, 0, 1)
        log.verdict_assert_equal?(:verdict_assert_equal_set, expected_set, actual_set)
        log.verdict_assert_equal?(:verdict_assert_equal_hash, expected_hash, actual_hash)
      end

      log.section('Use va_equal?') do
        log.va_equal?(:passing_va_equal, 0, 0)
        log.va_equal?(:failing_va_equal, 0, 1)
        log.va_equal?(:va_equal_set, expected_set, actual_set)
        log.va_equal?(:va_equal_hash, expected_hash, actual_hash)
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
        log.verdict_assert_in_delta?(:passing_verdict_assert_in_delta, 1, 1.1, 0.2)
        log.verdict_assert_in_delta?(:failing_verdict_assert_in_delta, 1, 1.2, 0.1)
      end

      log.section('Use va_in_delta?') do
        log.va_in_delta?(:passing_va_in_delta, 1, 1.1, 0.2)
        log.va_in_delta?(:failing_va_in_delta, 1, 1.2, 0.1)
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
        log.verdict_assert_in_epsilon?(:passing_verdict_assert_in_epsilon, 1, 1.1, 0.2)
        log.verdict_assert_in_epsilon?(:failing_verdict_assert_in_epsilon, 1, 1.2, 0.1)
      end

      log.section('Use va_in_epsilon?') do
        log.va_in_epsilon?(:passing_va_in_epsilon, 1, 1.1, 0.2)
        log.va_in_epsilon?(:failing_va_in_epsilon, 1, 1.2, 0.1)
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
        log.verdict_assert_includes?(:passing_verdict_assert_includes, [:a], :a)
        log.verdict_assert_includes?(:failing_verdict_assert_includes, [:b], :a)
      end

      log.section('Use va_includes?') do
        log.va_includes?(:passing_va_includes, [:a], :a)
        log.va_includes?(:failing_va_includes, [:b], :a)
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
        log.verdict_assert_instance_of?(:passing_verdict_assert_instance_of, String, 'Boo!')
        log.verdict_assert_instance_of?(:failing_verdict_assert_instance_of, String, 0)
      end

      log.section('Use va_instance_of?') do
        log.va_instance_of?(:passing_va_instance_of, String, 'Boo!')
        log.va_instance_of?(:failing_va_instance_of, String, 0)
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
        log.verdict_assert_kind_of?(:passing_verdict_assert_kind_of, StandardError, RuntimeError.new)
        log.verdict_assert_kind_of?(:failing_verdict_assert_kind_of, StandardError, 0)
      end

      log.section('Use va_kind_of?') do
        log.va_kind_of?(:passing_va_kind_of, StandardError, RuntimeError.new)
        log.va_kind_of?(:failing_va_kind_of, StandardError, 0)
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
        log.verdict_assert_match?(:passing_verdict_assert_match, /foo/, 'food')
        log.verdict_assert_match?(:failing_verdict_assert_match, /foo/, 'good')
      end

      log.section('Use va_match?') do
        log.va_match?(:passing_va_match, /foo/, 'food')
        log.va_match?(:failing_va_match, /foo/, 'good')
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
        log.verdict_assert_nil?(:passing_verdict_assert_nil, actual = nil)
        log.verdict_assert_nil?(:failing_verdict_assert_nil, actual = false)
      end

      log.section('Use alias va_nil?') do
        log.va_nil?(:passing_va_nil, actual = nil)
        log.va_nil?(:failing_va_nil, actual = false)
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
        log.verdict_assert_operator?(:passing_verdict_assert_operator, 1, :<, 2)
        log.verdict_assert_operator?(:failing_verdict_assert_operator, 2, :<, 1)
      end

      log.section('Use va_operator?') do
        log.va_operator?(:passing_va_operator, 1, :<, 2)
        log.va_operator?(:failing_va_operator, 2, :<, 1)
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
        log.verdict_assert_output?(:passing_verdict_assert_output, 'stdout', 'stderr') do
          $stdout.print('stdout')
          $stderr.print('stderr')
        end
        log.verdict_assert_output?(:failing_verdict_assert_output, 'stdout', 'stderr') do
          $stdout.print('not stdout')
          $stderr.print('not stderr')
        end

      end

      log.section('Use va_output?') do
        log.va_output?(:passing_va_output, 'stdout', 'stderr', 'Passing va_output?') do
          $stdout.print('stdout')
          $stderr.print('stderr')
        end
        log.va_output?(:failing_va_output, 'stdout', 'stderr', 'Failing va_output?') do
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
        log.verdict_assert_predicate?(:passing_verdict_assert_predicate, '', :empty?)
        log.verdict_assert_predicate?(:failing_verdict_assert_predicate, 'a', :empty?)
      end

      log.section('Use alias va_predicate?') do
        log.va_predicate?(:passing_va_predicate, '', :empty?)
        log.va_predicate?(:failing_va_predicate, 'a', :empty?)
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
        log.verdict_assert_raises?(:passing_verdict_assert_raises, RuntimeError) do
          raise RuntimeError.new('Boo!')
        end
        log.verdict_assert_raises?(:failing_verdict_assert_raises, RuntimeError) do
          # Nothing.
        end

      end

      log.section('Use va_raises?') do
        log.va_raises?(:passing_va_raises, RuntimeError, 'Passing va_raises?') do
          raise RuntimeError.new('Boo!')
        end
        log.va_raises?(:failing_va_raises, RuntimeError, 'Failing va_raises?') do
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
        log.verdict_assert_respond_to?(:passing_verdict_assert_respond_to, 'foo', :empty?)
        log.verdict_assert_respond_to?(:failing_verdict_assert_respond_to, 0, :empty?)
      end

      log.section('Use alias va_respond_to?') do
        log.va_respond_to?(:passing_va_respond_to, 'foo', :empty?)
        log.va_respond_to?(:failing_va_respond_to, 0, :empty?)
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
        log.verdict_assert_same?(:passing_verdict_assert_same, object, object)
        log.verdict_assert_same?(:failing_verdict_assert_same, object, different_object)
      end

      log.section('Use va_same?') do
        log.va_same?(:passing_va_same, object, object)
        log.va_same?(:failing_va_same, object, different_object)
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
        log.verdict_assert_silent?(:passing_verdict_assert_silent) do
          # Remain silent.
        end
        log.verdict_assert_silent?(:failing_verdict_assert_silent) do
          $stdout.print('Boo!')
        end

      end

      log.section('Use va_silent?') do
        log.va_silent?(:passing_va_silent) do
          # Remain silent.
        end
        log.va_silent?(:failing_va_silent) do
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
        log.verdict_assert_throws?(:passing_verdict_assert_throws, Exception) do
          throw Exception
        end
        log.verdict_assert_throws?(:failing_verdict_assert_throws, Exception) do
          # Nothing.
        end

      end

      log.section('Use va_throws?') do
        log.va_throws?(:passing_va_throws, Exception, 'Passing va_throws?') do
          throw Exception
        end
        log.va_throws?(:failing_va_throws, Exception, 'Failing va_throws?') do
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
        log.verdict_refute?(:passing_verdict_refute, actual = true)
        log.verdict_refute?(:failing_verdict_refute, actual = false)
        log.verdict_refute?(:volatile_verdict_refute, actual = true, volatile = true)
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
        log.verdict_refute_empty?(:passing_verdict_refute_empty, actual = [:a])
        log.verdict_refute_empty?(:failing_verdict_refute_empty, actual = [])
      end

      log.section('Use alias vr_empty?') do
        log.vr_empty?(:passing_vr_empty, actual = [:a])
        log.vr_empty?(:failing_vr_empty, actual = [])
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
        log.verdict_refute_equal?(:passing_verdict_refute_equal, 0, 1)
        log.verdict_refute_equal?(:failing_verdict_refute_equal, 0, 0)
      end

      log.section('Use vr_equal?') do
        log.vr_equal?(:passing_vr_equal, 0, 1)
        log.vr_equal?(:failing_vr_equal, 0, 0)
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
        log.verdict_refute_in_delta?(:passing_verdict_refute_in_delta, 1, 1.1, 0.2)
        log.verdict_refute_in_delta?(:failing_verdict_refute_in_delta, 1, 1.2, 0.1)
      end

      log.section('Use vr_in_delta?') do
        log.vr_in_delta?(:passing_vr_in_delta, 1, 1.2, 0.1)
        log.vr_in_delta?(:failing_vr_in_delta, 1, 1.1, 0.2)
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
        log.verdict_refute_in_epsilon?(:passing_verdict_refute_in_epsilon, 1, 1.2, 0.1)
        log.verdict_refute_in_epsilon?(:failing_verdict_refute_in_epsilon, 1, 1.1, 0.2)
      end

      log.section('Use vr_in_epsilon?') do
        log.vr_in_epsilon?(:passing_vr_in_epsilon, 1, 1.2, 0.1)
        log.vr_in_epsilon?(:failing_vr_in_epsilon, 1, 1.1, 0.2)
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
        log.verdict_refute_includes?(:passing_verdict_refute_includes, [:b], :a)
        log.verdict_refute_includes?(:failing_verdict_refute_includes, [:a], :a)
      end

      log.section('Use vr_includes?') do
        log.vr_includes?(:passing_vr_includes, [:b], :a)
        log.vr_includes?(:failing_vr_includes, [:a], :a)
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
        log.verdict_refute_instance_of?(:passing_verdict_refute_instance_of, String, 0)
        log.verdict_refute_instance_of?(:failing_verdict_refute_instance_of, String, 'Boo!')
      end

      log.section('Use vr_instance_of?') do
        log.vr_instance_of?(:passing_vr_instance_of, String, 0)
        log.vr_instance_of?(:failing_vr_instance_of, String, 'Boo!')
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
        log.verdict_refute_kind_of?(:passing_verdict_refute_kind_of, StandardError, 0)
        log.verdict_refute_kind_of?(:failing_verdict_refute_kind_of, StandardError, RuntimeError.new)
      end

      log.section('Use vr_kind_of?') do
        log.vr_kind_of?(:passing_vr_kind_of, StandardError, 0)
        log.vr_kind_of?(:failing_vr_kind_of, StandardError, RuntimeError.new)
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
        log.verdict_refute_match?(:passing_verdict_refute_match, /foo/, 'good',)
        log.verdict_refute_match?(:failing_verdict_refute_match, /foo/, 'food')
      end

      log.section('Use vr_match?') do
        log.vr_match?(:passing_vr_match, /foo/, 'good')
        log.vr_match?(:failing_vr_match, /foo/, 'food')
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
        log.verdict_refute_nil?(:passing_verdict_refute_nil, actual = false)
        log.verdict_refute_nil?(:failing_verdict_refute_nil, actual = nil)
      end

      log.section('Use alias vr_nil?') do
        log.vr_nil?(:passing_vr_nil, actual = false)
        log.vr_nil?(:failing_vr_nil, actual = nil)
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
        log.verdict_refute_operator?(:passing_verdict_refute_operator, 1, :>, 2)
        log.verdict_refute_operator?(:failing_verdict_refute_operator, 2, :>, 1)
      end

      log.section('Use vr_operator?') do
        log.vr_operator?(:passing_vr_operator, 1, :>, 2)
        log.vr_operator?(:failing_vr_operator, 2, :>, 1)
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
        log.verdict_refute_predicate?(:passing_verdict_refute_predicate, 'a', :empty?)
        log.verdict_refute_predicate?(:failing_verdict_refute_predicate, '', :empty?,)
      end

      log.section('Use alias vr_predicate?') do
        log.vr_predicate?(:passing_vr_predicate, 'a', :empty?)
        log.vr_predicate?(:failing_vr_predicate, '', :empty?)
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
        log.verdict_refute_respond_to?(:passing_verdict_refute_respond_to, 0, :empty?,)
        log.verdict_refute_respond_to?(:failing_verdict_refute_respond_to, 'foo', :empty?)
      end

      log.section('Use alias vr_respond_to?') do
        log.vr_respond_to?(:passing_vr_respond_to, 0, :empty?)
        log.vr_respond_to?(:failing_vr_respond_to, 'foo', :empty?)
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
        log.verdict_refute_same?(:passing_verdict_refute_same, object, different_object)
        log.verdict_refute_same?(:failing_verdict_refute_same, object, object)
      end

      log.section('Use vr_same?') do
        log.vr_same?(:passing_vr_same, object, different_object)
        log.vr_same?(:failing_vr_same, object, object)
      end

    end

  end

end
