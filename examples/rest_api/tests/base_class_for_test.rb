require 'minitest/autorun'

require_relative '../../../lib/helpers/test_helper'
require_relative '../rest_client'

class BaseClassForTest < Minitest::Test

  def prelude

    raise 'No block given' unless (block_given?)

    TestHelper.test(self) do |log|

      RestClient.with(log) do |client|
        yield client, log
      end

    end

  end


end

