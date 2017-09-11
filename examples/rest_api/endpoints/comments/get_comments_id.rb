require_relative '../../base_classes/endpoints/base_class_for_get_id'

require_relative '../../../rest_api/data/comment'

class GetCommentsId < BaseClassForGetId

  Contract ExampleRestClient, Comment => [Comment, Hash]
  def self.call_and_return_payload(client, comment)
    super
  end

  Contract ExampleRestClient, Log, String, Comment => Comment
  def self.verdict_call_and_verify_success(client, log, verdict_id, comment)
    super
  end

end
