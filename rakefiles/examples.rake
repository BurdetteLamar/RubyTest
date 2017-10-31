require_relative '../lib/helpers/test_helper'
require_relative '../lib/helpers/time_helper'

namespace :examples do

  desc 'Run all examples'
  task :all do
    rakefile_dir_path = File.dirname(__FILE__)
    %w/
      changes_report
      log
      rest_api
    /.each do |examples_dir_name|
      TestHelper.create_app_log_dir(examples_dir_name)
      rake_file_path = File.absolute_path(File.join(
                               rakefile_dir_path,
                               '..',
                               'examples',
                               examples_dir_name,
                               'Rakefile',
      ))
      command = format('rake -f %s examples', rake_file_path)
      system(command)
    end
  end

end
