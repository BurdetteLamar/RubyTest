require 'minitest/autorun'

require_relative '../../../lib/helpers/test_helper'
require_relative '../example_rest_client'

class BaseClassForTest < Minitest::Test

  def prelude

    raise 'No block given' unless (block_given?)

    log_dir_path = File.join(
        'examples',
        'rest_api',
        'output',
    )
    log_file_name = TestHelper.get_test_name + '.xml'
    log_file_path = File.join(log_dir_path, log_file_name)
    TestHelper.test(self, log_file_path) do |log|
      ExampleRestClient.with(log) do |client|
        yield client, log
      end
    end

  end


end

