require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataNewTest < BaseClassForTest

  def test_nested_data_new_2
    prelude do |_, log|
      log.section('Create and log nested data objects') do
        core = RateLimit::Core_.new(
            :limit => 5000,
            :remaining => 4984,
            :reset => 1507676679
        )
        search = RateLimit::Search.new(
            :limit => 30,
            :remaining => 30,
            :reset => 1507673695,
        )
        graphql = RateLimit::Graphql.new(
            :limit => 5000,
            :remaining => 5000,
            :reset => 1507677235,
        )
        resources = RateLimit::Resources.new(
            :core => core,
            :search => search,
            :graphql => graphql,
        )
        rate = RateLimit::Rate.new(
            :limit => 5000,
            :remaining => 4984,
            :reset => 1507676679,
        )
        rate_limit = RateLimit.new(
            {
                :resources => resources,
                :rate => rate,
            }
        )
        rate_limit.log(log)
      end
    end
  end

end
