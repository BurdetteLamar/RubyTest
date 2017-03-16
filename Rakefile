namespace :test do

  TEST_DIR = File.join(
      File.dirname(__FILE__),
      'test',
  )

  def autorun(test_file_path)
    path = File.absolute_path(File.join(
        TEST_DIR,
        test_file_path,
    ))
    command = "ruby #{path}"
    p command
    exit unless system(command)
  end

  desc 'Test class StringHelper'
  task :string_helper do
    autorun(File.join(
                    'helpers',
                    'string_helper_test.rb',
    )
    )
  end

  desc 'Test class ValuesHelper'
  task :values_helper do
    autorun(File.join(
        'helpers',
        'values_helper_test.rb',
    )
    )
  end

  desc 'Test all classes'
  task :all => %w/
     test:string_helper
     test:values_helper
   /

end
