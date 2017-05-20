require 'fileutils'

require_relative 'base_classes/base_class'

require_relative '../lib/helpers/set_helper'
require_relative '../lib/helpers/test_helper'

class ChangesReport < BaseClass

  Contract String, String => nil
  def self.create_report(app_name, report_file_path)

    prev_dir_path = TestHelper.get_app_log_dir_path(app_name, back = 1)
    prev_verdicts = Log.get_verdicts_from_directory(prev_dir_path)

    curr_dir_path = TestHelper.get_app_log_dir_path(app_name, back = 0)
    curr_verdicts = Log.get_verdicts_from_directory(curr_dir_path)

    # Key comparison (code far below) handles everything except a verdict
    # that was missing in both previous and current results.
    # For that, we need the collection of expected verdict paths.
    # It's in verdict_paths.txt, which we will update here.
    verdict_paths_file_path = File.join(
        File.dirname(curr_dir_path),
        'verdict_paths.txt',
    )
    FileUtils.touch(verdict_paths_file_path) unless File.exist?(verdict_paths_file_path)
    verdict_paths = []
    File.open(verdict_paths_file_path, 'r') do |file|
      lines = file.readlines
      verdict_paths = Set.new(lines.delete_if{|line| line.start_with?('#')})
      verdict_paths = Set.new(lines.delete_if{|line| line.gsub(/\s/, '').empty?})
      verdict_paths.collect!{|line| line.chomp }
      verdict_paths.merge(prev_verdicts.keys)
      verdict_paths.merge(curr_verdicts.keys)
    end
    updated_verdict_paths = <<EOT
# This file is updated automatically when the Changes Report is generated.

# Any new verdict path found in current or previous results is added.
# No verdict path is ever deleted automatically, so any needed culling
# (e.g., a verdict path that's not longer in the tests) must be manual.

# Most recently updated from:
# - #{prev_dir_path}
# - #{curr_dir_path}

#{verdict_paths.to_a.sort.join("\n")}

EOT
    File.open(verdict_paths_file_path, 'w') do |file|
      file.write(updated_verdict_paths)
    end

    key_comparison = SetHelper.compare(prev_verdicts.keys.to_set, curr_verdicts.keys.to_set)
    # Key comparison is hash with keys :missing, :unexpected, :ok.
    # Each :missing is a new blocked verdict.
    # Each :unexpected is a new passed verdict or a new failed verdict.
    # Each :ok is a verdict
    nil
  end

end