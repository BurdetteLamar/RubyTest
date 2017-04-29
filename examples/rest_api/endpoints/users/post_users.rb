require_relative '../base_classes/base_class_for_post'

require_relative '../../../rest_api/data/user'

class PostUsers < BaseClassForPost

  Contract ExampleRestClient, User => [User, Any]
  def self.call_and_return_payload(client, user)
    super
  end

  Contract ExampleRestClient, Log, String, User => User
  def self.verdict_call_and_verify_success(client, log, verdict_id, user)
    super
  end

end
