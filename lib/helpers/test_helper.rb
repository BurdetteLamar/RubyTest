require 'minitest/test'
require 'rbconfig'

require_relative '../../lib/base_classes/base_class'

require_relative '../../lib/log/log'
require_relative 'time_helper'

class TestHelper < BaseClass

  Contract Minitest::Test, Or[String, Proc], Maybe[Proc] => NilClass
  # Set up for a test.
  def self.test(test, log_dir_path = '.')
    raise 'No block given' unless (block_given?)
    FileUtils.mkdir_p(log_dir_path)
    test_name, test_method_name = self.get_test_name_and_test_method_name
    # TODO:  Get log directory path from configuration file.
    # TODO:  Construct file path from directory path and test name.
    log_file_name = test_name + '.xml'
    log_file_path = File.join(log_dir_path, log_file_name)
    Log.open(test, :root_name => test_method_name, :file_path => log_file_path) do |log|
      log.test_method(:rescue, :timestamp, :duration, :name => test_method_name) do
        yield log
      end
    end
  end

  Contract None => ArrayOf[String]
  # Get the test file name (without the extension), and the test name
  def self.get_test_name_and_test_method_name
    # We are getting the test name from the call stack.
    # It begins with 'test_'
    all_names = []
    test_files_by_name = {}
    caller.each do |_caller|
      words = _caller.split(/\W/)
      test_name = words[-6]
      name = words.last
      all_names.push(name)
      if name.start_with?('test_')
        test_files_by_name.store(name, test_name)
      end
    end
    case test_files_by_name.size
      when 0
        message = 'Found no test name among %s' % all_names.inspect
        raise Exception.new(message)
      when 1
        return test_files_by_name.to_a.first
      else
        message = 'Found %d test names and files:  %s' % test_files_by_name.inspect
        raise Exception.new(message)
    end
  end

  Contract None => String
  def self.get_test_name
    _, test_name = self.get_test_name_and_test_method_name
    test_name
  end

  Contract None => String
  def self.get_method_name
    method_name, _ = self.get_test_name_and_test_method_name
    method_name
  end

  def self.get_log_root_dir_path
    host_os = RbConfig::CONFIG['host_os']
    dir_path = case
      when host_os =~ /mswin|windows|cygwin|mingw32/i
        # Some Windows OS.
        File.join(
            ENV['appdata'],
            'RubyTest',
            'logs',
        )
      when host_os =~ /linux/i
        # Some linux OS.
        '/var/log/RubyTest'
      else
        raise NotImplementedError.new(host_os)
               end
    File.absolute_path(dir_path)
  end

  def self.create_log_root_dir
    log_root_dir_path = self.get_log_root_dir_path
    FileUtils.mkdir_p(log_root_dir_path)
    log_root_dir_path
  end

  def self.create_app_log_dir(app_name)
    dir_path = File.join(
                       self.get_log_root_dir_path,
                       app_name,
                       TimeHelper.timestamp(milliseconds = false),
    )
    FileUtils.mkdir_p(dir_path)
    dir_path
  end

  # Get app test logs directory path.
  # This will have a timestamp directory name.
  # Accepts a non-positive offset into the list of directory names:
  # 0 for most recent result;  -1 for the next earlier;  etc.
  Contract String, And[Num, Not[Neg]] => String
  def self.get_app_log_dir_path(app_name, back = 0)
    timestamp_dir_names = Dir.glob(File.join(
        self.get_log_root_dir_path,
        app_name,
        '*',
        ''
    ))
    timestamp_dir_names.sort.reverse[back]
  end

end
