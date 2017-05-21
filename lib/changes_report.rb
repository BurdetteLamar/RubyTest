require 'fileutils'

require_relative 'base_classes/base_class'

require_relative '../lib/helpers/set_helper'
require_relative '../lib/helpers/test_helper'

class ChangesReport < BaseClass

  class VerdictPair

    attr_accessor :prev, :curr, :status
    def initialize(prev_verdict, curr_verdict)

    end

  end

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
    lines = nil
    File.open(verdict_paths_file_path, 'r') do |file|
      lines = file.readlines
    end

    lines = lines.delete_if{|line| line.start_with?('#')}
    lines = lines.delete_if{|line| line.gsub(/\s/, '').empty?}
    expected_verdict_paths = lines.collect{|line| line.chomp }.to_set

    prev_verdict_paths = Set.new(prev_verdicts.keys)
    curr_verdict_paths = Set.new(curr_verdicts.keys)
    updated_verdict_paths = Set.new(expected_verdict_paths).merge(curr_verdict_paths)

    updated_verdict_paths_text = <<EOT
# This file is updated automatically when the Changes Report is generated.

# Any new verdict path found in current or previous results is added.
# No verdict path is ever deleted automatically, so any needed culling
# (e.g., a verdict path that's not longer in the tests) must be manual.

# Most recently updated""
# - at #{TimeHelper.timestamp}
# - from #{curr_dir_path}

#{updated_verdict_paths.to_a.sort.join("\n")}

EOT
    File.open(verdict_paths_file_path, 'w') do |file|
      file.write(updated_verdict_paths_text)
    end

    # Key comparison is hash with keys :missing, :unexpected, :ok.
    key_comparison = SetHelper.compare(prev_verdicts.keys.to_set, curr_verdicts.keys.to_set)
    verdict_pairs = {}

    key_comparison.fetch(:missing).each do |verdict_path|
      prev_verdict = prev_verdicts.fetch(verdict_path)
      curr_verdict = nil
      verdict_pair = ChangesReport::VerdictPair.new(prev_verdict, curr_verdict)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    key_comparison.fetch(:unexpected).each do |verdict_path|
      prev_verdict = nil
      curr_verdict = curr_verdicts.fetch(verdict_path)
      verdict_pair = ChangesReport::VerdictPair.new(prev_verdict, curr_verdict)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    key_comparison.fetch(:ok).each do |verdict_path|
      prev_verdict = prev_verdicts.fetch(verdict_path)
      curr_verdict = curr_verdicts.fetch(verdict_path)
      verdict_pair = ChangesReport::VerdictPair.new(prev_verdict, curr_verdict)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    # One more case:  Verdict was in neither prev or curr, but was expected
    # (i.e., was in verdict_paths.txt).
    p expected_verdict_paths.class
    p prev_verdict_paths.class
    p curr_verdict_paths.class
    old_blocked_paths = expected_verdict_paths - prev_verdict_paths - curr_verdict_paths
    old_blocked_paths.each do |verdict_path|
      verdict_pair = ChangesReport::VerdictPair.new(nil, nil)
    end

    # Ok:  verdict was in both prev and curr.
    # Old passed:  both passed with no change.
    # Old failed:  both failed with no change.
    # Changed passed:  both passed with change.
    # Changed failed:  both failed with change.
    # New failed:  prev passed, curr failed.
    # New passed:  prev failed, curr passed.

    # Missing:  verdict was in prev, but not in curr.
    # New blocked.

    # Unexpected:  Verdict was in curr, but not in prev.
    # New passed.
    # New failed.

    # Old blocked.
    nil
  end

end