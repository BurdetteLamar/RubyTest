require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataEqualTest < BaseClassForTest

  def test_nested_data_equal
    prelude do |client, log|
      rate_limit_0 = RateLimit.get(client)
      rate_limit_1 = RateLimit.deep_clone(rate_limit_0)
      log.section('These are equal') do
        fail unless RateLimit.equal?(rate_limit_0, rate_limit_1)
        RateLimit.verdict_equal?(log, 'rate limits equal', rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
      end
      log.section('These are not equal') do
        rate_limit_1.resources.core.limit += 1.0
        fail if RateLimit.equal?(rate_limit_0, rate_limit_1)
        RateLimit.verdict_equal?(log, 'rate limits not equal', rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
      end
    end
  end

end
