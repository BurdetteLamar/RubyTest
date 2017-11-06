require_relative '../../base_classes/endpoints/base_class_for_delete_id'

require_relative '../../../rest_api/data/user'

class DeleteUsersId < BaseClassForDeleteId

  Contract ExampleRestClient, User => nil
  def self.call_and_return_payload(client, user)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, User => nil
  def self.verdict_call_and_verify_success(client, log, verdict_id, user)
    super
  end

end
