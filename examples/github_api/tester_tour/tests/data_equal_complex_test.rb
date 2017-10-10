require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataEqualTest < BaseClassForTest

  def test_data_equal_complex
    prelude do |client, log|
      user_0 = User.get_first(client)
      user_1 = User.deep_clone(user_0)
      log.section('These are equal') do
        fail unless User.equal?(user_0, user_1)
        User.verdict_equal?(log, 'user equal', user_0, user_1, 'Using User.verdict_equal?')
      end
      log.section('These are not equal') do
        user_1.address.geo.lat += 1.0
        fail if User.equal?(user_0, user_1)
        User.verdict_equal?(log, 'user not equal', user_0, user_1, 'Using User.verdict_equal?')
      end
    end
  end

end
