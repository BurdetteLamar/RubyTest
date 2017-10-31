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
            method,
            pass_values,
            changed_pass_values,
            fail_values,
            changed_fail_values
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
            if @verdict_ids.include?(key)
              verdict_id = @verdict_ids.fetch(key)
              message = @messages.fetch(key)
            else
              verdict_id = @lorem.words(3)
              @verdict_ids.store(key, verdict_id)
              message = @lorem.sentence(4)
              @messages.store(key, message)
            end
            # For debugging;  tells what we're trying to do.
            # message = key.inspect
            @log.send(method, verdict_id, *args, message)
          end
        end

        values_for_method = {
            :verdict_assert? => {
                :pass => true,
                :changed_pass => [1],
                :fail => false,
                :changed_fail => [nil],
            },
            :verdict_assert_empty? => {
                :pass => [''],
                :changed_pass => [[]],
                :fail => ['a'],
                :changed_fail => ['b'],
            },
            :verdict_assert_equal? => {
                :pass => [0, 0],
                :changed_pass => [1, 1],
                :fail => [0, 1],
                :changed_fail => [0, 2],
            },
            :verdict_assert_in_delta? => {
                :pass => [0.0, 0.1, 0.2],
                :changed_pass => [1.0, 1.1, 0.2],
                :fail=> [0.0, 1.0, 0.2],
                :changed_fail=> [1.0, 2.0, 0.2],
            },
            :verdict_assert_in_epsilon? => {
                :pass => [0.0, 0.0, 1.0],
                :changed_pass => [1.0, 1.0, 1.0],
                :fail => [0.0, 4.0, 1.0],
                :changed_fail => [0.0, 5.0, 1.0],
            }
        }

        values_for_method.each_pair do |assert_method, values|
          do_method(
              assert_method,
              values.fetch(:pass),
              values.fetch(:changed_pass),
              values.fetch(:fail),
              values.fetch(:changed_fail)
          )
          refute_method = assert_method.to_s.sub('assert', 'refute').to_sym
          # Not all assert methods have corresponding refute methods.
          next unless @log.respond_to?(refute_method)
          # For refute, we reverse the data:  pass <=> fail.
          do_method(
              refute_method,
              values.fetch(:fail),
              values.fetch(:changed_fail),
              values.fetch(:pass),
              values.fetch(:changed_pass),
          )
        end


      end

    end


  end

  def test_changes

    # Remove verdict_paths.txt, so we get a clean comparison of prev and curr.
    curr_dir_path = TestHelper.get_app_log_dir_path('changes_report', back = 0)
    verdict_paths_file_path = File.join(
        File.dirname(curr_dir_path),
        'verdict_paths.txt',
    )
    # Make sure we get a clean verdicts list.
    File.delete(verdict_paths_file_path)
    # Put in some verdicts that will be 'old blocked'.
    File.open(verdict_paths_file_path, 'w') do |file|
      lorem = LoremHelper::Lorem.new
      (0..9).each do
        verdict_id = lorem.words(3)
        verdict_path = format('log/%s', verdict_id)
        file.puts(verdict_path)
      end
    end

    # Need to preserve verdict id and message from prev to curr.
    @verdict_ids = {}
    @messages = {}

    # Create logs for prev.
    create_logs(prev = true)

    # Make sure the timestamp-based directory names will be different.
    sleep 2

    # Create logs for curr.
    create_logs(prev = false)

  end

end