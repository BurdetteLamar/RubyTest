require_relative 'base_class_for_test'

require_relative '../endpoints/users/delete_users_id'
require_relative '../endpoints/users/get_users'
require_relative '../endpoints/users/get_users_id'
require_relative '../endpoints/users/post_users'
require_relative '../endpoints/users/put_users_id'

require_relative '../data/user'
require_relative '../../../lib/log/log'

class UsersTest < BaseClassForTest

  def test_delete_users_id

    prelude do |client, log|
      log.section('Test DeleteUsers') do
        user_to_delete = nil
        log.section('Get a user to delete') do
          user_to_delete = User.get_first(client)
        end
        log.section('Delete the user') do
          # This should fail, because JSONplaceholder will not actually delete the user.
          DeleteUsersId.verdict_call_and_verify_success(client, log, 'delete user', user_to_delete)
        end
      end
    end
  end

  def test_get_users

    prelude do |client, log|
      log.section('Test GetUsers') do
        GetUsers.verdict_call_and_verify_success(client, log, 'get users')
      end
    end

  end

  def test_get_users_id

    prelude do |client, log|
      log.section('Test GetUsersId') do
        user_to_fetch = nil
        log.section('Get a user to fetch') do
          user_to_fetch = User.get_first(client)
        end
        log.section('Fetch the user') do
          GetUsersId.verdict_call_and_verify_success(client, log, 'get user', user_to_fetch)
        end
      end
    end

  end

  def test_post_users

    prelude do |client, log|
      log.section('Test PostUsers') do
        user_to_post = User.new(
            :id => 1,
            :name => 'Leanne Graham',
            :username => 'Bret',
            :email => 'Sincere@april.biz',
            :address => {
                :street => 'Kulas Light',
                :suite => 'Apt. 556',
                :city => 'Gwenborough',
                :zipcode => '92998-3874',
                :geo => {
                    :lat => '-37.3159',
                    :lng => '81.1496'
                }
            },
            :phone => '1-770-736-8031 x56442',
            :website => 'hildegard.org',
            :company => {
                :name => 'Romaguera-Crona',
                :catchPhrase => 'Multi-layered client-server neural-net',
                :bs => 'harness real-time e-markets'
            }
        )
        # This should fail, because JSONplaceholder will not actually create the user.
        PostUsers.verdict_call_and_verify_success(client, log, 'user to_create', user_to_post)
      end
    end

  end

  def test_put_users_id

    prelude do |client, log|
      log.section('Test PutUsers') do
        user_to_put = nil
        log.section('Get a user to put') do
          user_original = User.get_first(client)
          user_to_put = user_original.clone
        end
        log.section('Put the modifications') do
          user_to_put.name = 'New name'
          # This should fail, because JSONplaceholder will not actually update the user.
          PutUsersId.verdict_call_and_verify_success(client, log, 'User to put', user_to_put)
        end
      end

    end

  end

end

