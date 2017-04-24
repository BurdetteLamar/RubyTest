require_relative 'base_class_for_test'

require_relative '../endpoints/users/get_users'
require_relative '../endpoints/users/get_users_id'

require_relative '../data/user'
require_relative '../../../lib/log/log'

class UsersTest < BaseClassForTest

  def test_get_users

    prelude do |client, log|

      GetUsers.verdict_call_and_verify_success(client, log, 'get users')

    end

  end

  def test_get_users_id

    prelude do |client, log|

      user_to_fetch = User.get_any(client)
      GetUsersId.verdict_call_and_verify_success(client, log, 'get user', user_to_fetch)
    end
  end

end
