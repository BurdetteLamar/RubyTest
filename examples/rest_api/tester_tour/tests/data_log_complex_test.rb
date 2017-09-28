require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataLogComplexTest < BaseClassForTest

  def test_data_log_complex
    prelude do |client, log|
      log.section('Fetch and log an instance of User') do
        log.section('Fetch a user') do
          user = User.get_first(client)
        end
        log.section('Log fetched user') do
          user.log(log)
        end
      end
    end
  end

end
