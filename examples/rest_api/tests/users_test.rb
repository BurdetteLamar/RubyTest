require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/users/delete_users_id'
require_relative '../endpoints/users/get_users'
require_relative '../endpoints/users/get_users_id'
require_relative '../endpoints/users/post_users'
require_relative '../endpoints/users/put_users_id'

class UsersTest < BaseClassForTest

  def test_delete_users_id

    prelude do |client, log|
      log.section('Test DeleteUsersId') do
        user_to_delete = nil
        log.section('Get a user to delete') do
          user_to_delete = User.get_first(client)
        end
        log.section('Delete the user') do
          DeleteUsersId.verdict_call_and_verify_success(client, log, :delete_user, user_to_delete)
        end
      end
    end
  end

  def test_get_users

    prelude do |client, log|
      log.section('Test GetUsers') do

        all_users = nil

        log.section('GetUsers with no query') do
          all_users = GetUsers.verdict_call_and_verify_success(client, log, :no_query)
        end

        log.section('GetUsers with simple query') do
          user = all_users.first
          query_elements = {
              :name => user.name,
          }
          expected_users = all_users.select { |p| p.name == user.name }
          actual_users = GetUsers.call(client, query_elements)
          if log.verdict_assert_equal?(:count_for_simple_query, expected_users.size, actual_users.size)
            (0...expected_users.size).each do |i|
              expected_user = expected_users[i]
              actual_user = actual_users[i]
              v_id = format('with_simple_query_%d', i).to_sym
              User.verdict_equal?(log, v_id, expected_user, actual_user)
            end
          end
        end

        log.section('GetUsers with complex query') do
          user = all_users.first
          query_elements = {
              :name => user.name,
              :phone => user.phone,
          }
          expected_users = all_users.select { |p| (p.name == user.name) && (p.phone == user.phone) }
          actual_users = GetUsers.call(client, query_elements)
          if log.verdict_assert_equal?(:count_for_complex_query, expected_users.size, actual_users.size)
            (0...expected_users.size).each do |i|
              expected_user = expected_users[i]
              actual_user = actual_users[i]
              v_id = format('with_complex_query_%d', i).to_sym
              User.verdict_equal?(log, v_id, expected_user, actual_user, 'User %d' % i)
            end
          end
        end

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
          GetUsersId.verdict_call_and_verify_success(client, log, :get_user, user_to_fetch)
        end
      end
    end

  end

  def test_post_users

    prelude do |client, log|
      log.section('Test PostUsers') do
        user_to_create = User.new(
            :id => nil,
            :name => 'New name',
            :username => 'NewUsername',
            :email => 'New@Email.com',
            :address => {
                :street => 'New Street',
                :suite => 'New Suite',
                :city => 'New City',
                :zipcode => '55555-5555',
                :geo => {
                    :lat => '0.0',
                    :lng => '0.0'
                }
            },
            :phone => '1-555-555-5555 x55',
            :website => 'NewWebsite.org',
            :company => {
                :name => 'New Company Name',
                :catchPhrase => 'New catchphrase',
                :bs => 'New BS'
            }
        )
        PostUsers.verdict_call_and_verify_success(client, log, :user_to_create, user_to_create)
      end
    end

  end

  def test_put_users_id

    prelude do |client, log|
      log.section('Test PutUsersId') do
        user_existing = User.get_first(client)
        log.section('Put the modifications') do
          user_to_update = User.new(
              :id => user_existing.id,
              :name => 'New name',
              :username => 'NewUsername',
              :email => 'New@Email.com',
              :address => {
                  :street => 'New Street',
                  :suite => 'New Suite',
                  :city => 'New City',
                  :zipcode => '55555-5555',
                  :geo => {
                      :lat => '0.0',
                      :lng => '0.0'
                  }
              },
              :phone => '1-555-555-5555 x55',
              :website => 'NewWebsite.org',
              :company => {
                  :name => 'New Company Name',
                  :catchPhrase => 'New catchphrase',
                  :bs => 'New BS'
              }
          )
          user_to_update.name = 'New name'
          PutUsersId.verdict_call_and_verify_success(client, log, :user_to_update, user_to_update)
        end
      end

    end

  end

end

