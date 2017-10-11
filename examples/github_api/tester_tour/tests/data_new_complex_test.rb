require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class DataNewComplexTest < BaseClassForTest

  def test_data_new_complex
    prelude do |_, log|
      log.section('Create and log an instance of a complex data object') do
        rate_limit = RateLimit.new(
            {
                :resources => {
                    :core => {
                        :limit => 5000,
                        :remaining => 4984,
                        :reset => 1507676679,
                    },
                    :search => {
                        :limit => 30,
                        :remaining => 30,
                        :reset => 1507673695,
                    },
                    :graphql => {
                        :limit => 5000,
                        :remaining => 5000,
                        :reset => 1507677235,
                    }
                },
                :rate => {
                    :limit => 5000,
                    :remaining => 4984,
                    :reset => 1507676679,
                }
            }
        )
        rate_limit.log(log)
      end
    end
  end

end
