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
    TestHelper.test(self, log_dir_path) do |log|
      ExampleRestClient.with(log) do |client|
        yield client, log
      end
    end

  end


end

