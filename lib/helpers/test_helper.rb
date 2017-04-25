require_relative '../../lib/base_classes/base_class'

require_relative '../../lib/log/log'

class TestHelper < BaseClass

  Contract Minitest::Test, Or[String, Proc], Maybe[Proc] => NilClass
  # Set up for a test.
  def self.test(test, log_dir_path = '.')
    raise 'No block given' unless (block_given?)
    FileUtils.mkdir_p(log_dir_path)
    test_name = self.get_test_name
    # TODO:  Get log directory path from configuration file.
    # TODO:  Construct file path from directory path and test name.
    log_file_name = test_name + '.xml'
    log_file_path = File.join(log_dir_path, log_file_name)
    Log.open(test, :root_name => test_name, :file_path => log_file_path) do |log|
      log.test_method(:rescue, :timestamp, :duration, :name => test_name) do
        yield log
      end
    end
  end

  Contract None => ArrayOf[String]
  # Get the test file name (without the extension), and the test name
  def self.get_test_file_name_and_test_name
    # We are getting the test name from the call stack.
    # It begins with 'test_'
    all_names = []
    test_files_by_name = {}
    caller.each do |_caller|
      words = _caller.split(/\W/)
      test_file_name = words[-6]
      name = words.last
      all_names.push(name)
      if name.start_with?('test_')
        test_files_by_name.store(name, test_file_name)
      end
    end
    case test_files_by_name.size
      when 0
        message = 'Found no test name among %s' % all_names.inspect
        raise Exception.new(message)
      when 1
        test_name = test_files_by_name.keys.first
        test_file_name = test_files_by_name.fetch(test_name)
        return [test_name, test_file_name]
      else
        message = 'Found %d test names and files:  %s' % test_files_by_name.inspect
        raise Exception.new(message)
    end
  end

  Contract None => String
  # Return the name of the current test.
  def self.get_test_name
    _, test_name = self.get_test_file_name_and_test_name
    test_name
  end

end
