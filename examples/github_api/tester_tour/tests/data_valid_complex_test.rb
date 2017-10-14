require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class DataValidComplexTest < BaseClassForTest

  def test_data_valid_complex
    prelude do |client, log|
      rate_limit = RateLimit.get(client)
      log.section('This is valid') do
        rate_limit.verdict_valid?(log, 'rate limit valid')
      end
      log.section('This is not valid') do
        rate_limit.resources.core.reset = RateLimit::Core_.invalid_value_for(:reset)
        rate_limit.verdict_valid?(log, 'rate limit not valid')
      end
    end
  end

end
