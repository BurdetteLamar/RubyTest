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

    # Key comparison handles everything except a verdict that was missing in both.
    # For that, we need a reference set of verdict paths.
    # TODO:  Make reference set of verdict paths.

    key_comparison = SetHelper.compare(prev_verdicts.keys.to_set, curr_verdicts.keys.to_set)
    # Key comparison is hash with keys :missing, :unexpected, :ok.
    # Each :missing is a new blocked verdict.
    # Each :unexpected is a new passed verdict or a new failed verdict.
    # Each :ok is a verdict
    nil
  end

end