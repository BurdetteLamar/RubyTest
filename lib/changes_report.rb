require_relative 'base_classes/base_class'

require_relative '../lib/helpers/test_helper'

class ChangesReport < BaseClass

  Contract String, String => nil
  def self.create_report(app_name, report_file_path)
    prev_dir_path = TestHelper.get_app_log_dir_path(app_name, back = 1)
    prev_verdicts = Log.get_verdicts_from_directory(prev_dir_path)
    p prev_verdicts.size
    curr_dir_path = TestHelper.get_app_log_dir_path(app_name, back = 0)
    curr_verdicts = Log.get_verdicts_from_directory(curr_dir_path)
    p curr_verdicts.size
    nil
  end

end