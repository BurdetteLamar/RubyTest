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
    exit unless system(command)
  end

  desc 'Test class Configuration'
  task :configuration do
    autorun(File.join(
                '..',
                '..',
                'test',
                'configuration_test.rb',
            )
    )
  end

  desc 'Test class DebugHelper'
  task :debug_helper do
    autorun(File.join(
        '..',
        '..',
        'test',
        'helpers',
        'debug_helper_test.rb',
    )
    )
  end

  desc 'Test class HashHelper'
  task :hash_helper do
    autorun(File.join(
        '..',
        '..',
        'test',
        'helpers',
        'hash_helper_test.rb',
    )
    )
  end

  desc 'Test class Log'
  task :log do
    autorun(File.join(
        '..',
        '..',
        'test',
        'log_test.rb',
    )
    )
  end

  desc 'Test class SetHelper'
  task :set_helper do
    autorun(File.join(
        '..',
        '..',
        'test',
        'helpers',
        'set_helper_test.rb',
    )
    )
  end

  desc 'Test class StringHelper'
  task :string_helper do
    autorun(File.join(
        '..',
        '..',
        'test',
        'helpers',
        'string_helper_test.rb',
    )
    )
  end

  desc 'Test class ValuesHelper'
  task :values_helper do
    autorun(File.join(
        '..',
        '..',
        'test',
        'helpers',
        'values_helper_test.rb',
    )
    )
  end

  desc 'Test all classes'
  task :all => %w/
      test:configuration
      test:hash_helper
      test:log
      test:set_helper
      test:string_helper
      test:values_helper
   /

end
