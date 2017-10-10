require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class DataLogComplexTest < BaseClassForTest

  def test_data_log_complex
    prelude do |client, log|
      log.section('Fetch and log rate limit') do
        rate_limit = nil
        log.section('Fetch rate limit') do
          rate_limit = RateLimit.get(client)
        end
        rate_limit.log(log, 'Fetched user')
      end
    end
  end

end
