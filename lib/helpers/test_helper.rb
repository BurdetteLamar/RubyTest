require_relative '../../lib/base_class'

require_relative '../../lib/log'

class TestHelper < BaseClass

  Contract Minitest::Test, Proc => NilClass
  # Set up for a test.
  def self.test(test)
    raise 'No block given' unless (block_given?)
    test_name = self.get_test_name
    # TODO:  Get log directory path from configuration file.
    # TODO:  Construct file path from directory path and test name.
    xml_log_file_path = 'log.xml'
    Log.open(test, :root_name => test_name, :file_path => xml_log_file_path) do |log|
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
    test_names = []
    test_file_names = []
    caller.each do |_caller|
      words = _caller.split(/\W/)
      test_file_name = words[-6]
      name = words.last
      all_names.push(name)
      if name.start_with?('test_')
        test_names.push(name)
        test_file_names.push(test_file_name)
      end
    end
    case test_names.size
      when 0
        message = 'Found no test name among %s' % all_names.inspect
        raise Exception.new(message)
      when 1
        return [test_file_names.first, test_names.first]
      else
        message = 'Found %d test names among %s' % [test_names.size, all_names.inspect]
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
