require_relative '../../base_classes/endpoints/base_class_for_get_id'

require_relative '../../../rest_api/data/user'

class GetUsersId < BaseClassForGetId

  Contract ExampleRestClient, User => [User, Hash]
  def self.call_and_return_payload(client, user)
    super
  end

  Contract ExampleRestClient, Log, String, User => User
  def self.verdict_call_and_verify_success(client, log, verdict_id, user)
    super
  end

end
