require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataEqualTest < BaseClassForTest

  def test_data_equal_complex
    prelude do |client, log|
      user = User.get_first(client)
      User.equal?(user, user)
      User.verdict_equal?(log, 'user equal', user, user, 'Using User.verdict_equal?')
    end
  end

end
