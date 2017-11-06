require_relative '../../base_classes/endpoints/base_class_for_delete_id'

require_relative '../../../rest_api/data/comment'

class DeleteCommentsId < BaseClassForDeleteId

  Contract ExampleRestClient, Comment => nil
  def self.call_and_return_payload(client, comment)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Comment => nil
  def self.verdict_call_and_verify_success(client, log, verdict_id, comment)
    super
  end

end
