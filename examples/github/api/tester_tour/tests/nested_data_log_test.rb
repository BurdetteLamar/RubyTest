require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataLogTest < BaseClassForTest

  def test_nested_data_log
    prelude do |client, log|
      log.section('Fetch and log a rate limit') do
        rate_limit = nil
        log.section('Fetch rate limit') do
          rate_limit = RateLimit.get(client)
        end
        rate_limit.log(log, 'Fetched rate limit')
      end
    end
  end

end

