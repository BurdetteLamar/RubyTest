require 'minitest/autorun'

require_relative '../../lib/helpers/test_helper'
require_relative '../../lib/log/log'
require_relative '../../lib/lorem_helper'

class ExampleTest < Minitest::Test

  def create_logs(prev)

    @prev = prev

    @lorem = LoremHelper::Lorem.new

    log_dir_path = TestHelper.create_app_log_dir('changes_report')
    log_file_path = File.join(
                            log_dir_path,
                            'log.xml'
    )
    Log.open(self, :file_path => log_file_path, :backtrace_filter => /ruby/) do |log|

      @log = log

      section_title = format('Log for %s test run', prev ? 'previous' : 'current')
      @log.section(section_title, :timestamp, :duration) do

        def do_method(
          method:,
          pass_values:,
          changed_pass_values:,
          fail_values:,
          changed_fail_values:
        )
          block_values = nil
          # Arguments for prev and curr data.
          args_for_status = {
                :old_passed => [pass_values, pass_values],
                :new_passed => [fail_values, pass_values],
                :changed_passed => [pass_values, changed_pass_values],
                :old_failed => [fail_values, fail_values],
                :new_failed => [pass_values, fail_values],
                :changed_failed => [fail_values, changed_fail_values],
                :old_blocked => [block_values, block_values],
                :new_blocked => [pass_values, block_values],
          }
          i = @prev ? 0 : 1
          args_for_status.each_pair do |status, args_pair|
            args = args_pair[i]
            next if args.nil?
            key = [method, status]
            verdict_id = nil
            if @verdict_ids.include?(key)
              verdict_id = @verdict_ids.fetch(key)
            else
              verdict_id = @lorem.words(3)
              @verdict_ids.store(key, verdict_id)
            end
            @log.send(method, verdict_id, *args, verdict_id)
          end
        end

        do_method(
            method: :verdict_assert?,
            pass_values: [true],
            changed_pass_values: [1],
            fail_values: [false],
            changed_fail_values: [nil],
        )
        do_method(
            method: :verdict_refute?,
            pass_values: [false],
            changed_pass_values: [nil],
            fail_values: [true],
            changed_fail_values: [1],
        )

        do_method(
            method: :verdict_assert_empty?,
            pass_values: [''],
            changed_pass_values: [[]],
            fail_values: ['a'],
            changed_fail_values: ['b'],
        )
        do_method(
            method: :verdict_refute_empty?,
            pass_values: ['a'],
            changed_pass_values: ['b'],
            fail_values: ['true'],
            changed_fail_values: [[]],
        )

        do_method(
            method: :verdict_assert_equal?,
            pass_values: [0, 0],
            changed_pass_values: [1, 1],
            fail_values: [0, 1],
            changed_fail_values: [0, 2],
        )
        do_method(
            method: :verdict_refute_equal?,
            pass_values: [0, 1],
            changed_pass_values: [0, 2],
            fail_values: [0, 0],
            changed_fail_values: [1, 1],
        )

        do_method(
            method: :verdict_assert_in_delta?,
            pass_values: [0.0, 0.1, 0.2],
            changed_pass_values: [1.0, 1.1, 0.2],
            fail_values: [0.0, 1.0, 0.2],
            changed_fail_values: [1.0, 2.0, 0.2],
        )
        do_method(
            method: :verdict_refute_in_delta?,
            pass_values: [0.0, 1.0, 0.2],
            changed_pass_values: [1.0, 2.0, 0.2],
            fail_values: [0.0, 0.1, 0.2],
            changed_fail_values: [1.0, 1.1, 0.2],
        )

      end

    end


  end

  def test_changes

    @verdict_ids = {}

    create_logs(prev = true)
    # Make sure the timestamp-based dirnames will be different.
    sleep 2
    create_logs(prev = false)

  end

end