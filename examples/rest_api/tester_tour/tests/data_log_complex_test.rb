require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataLogComplexTest < BaseClassForTest

  def test_data_log_complex
    prelude do |client, log|
      log.section('Fetch and log an instance of User') do
        user = nil
        log.section('Fetch a user') do
          user = User.get_first(client)
        end
        user.log(log, 'Fetched user')
      end
    end
  end

end
