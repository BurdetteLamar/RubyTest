namespace :examples do

  desc 'Run all examples'
  task :all do
    rakefile_dir_path = File.dirname(__FILE__)
    %w/
      log
      rest_api
    /.each do |examples_dir_name|
      rake_file_path = File.join(
                               rakefile_dir_path,
                               '..',
                               'examples',
                               examples_dir_name,
                               'Rakefile',
      )
      # p rake_file_path
      command = 'rake -f %s examples' % rake_file_path
      system(command)
    end
  end

end
