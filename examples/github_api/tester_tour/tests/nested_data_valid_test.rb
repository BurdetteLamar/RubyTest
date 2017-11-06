require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataValidTest < BaseClassForTest

  def test_nested_data_valid
    prelude do |client, log|
      rate_limit = RateLimit.get(client)
      log.section('This is valid') do
        rate_limit.verdict_valid?(log, :rate_limit_valid)
      end
      log.section('This is not valid') do
        rate_limit.resources.core.reset = RateLimit::Core_.invalid_value_for(:reset)
        rate_limit.verdict_valid?(log, :rate_limit_not_valid)
      end
    end
  end

end
