require_relative '../base_classes/base_class_for_put_id'

require_relative '../../../rest_api/data/comment'

class PutCommentsId < BaseClassForPutId

  Contract ExampleRestClient, Comment => [Comment, Any]
  def self.call_and_return_payload(client, comment)
    super
  end

  Contract ExampleRestClient, Log, String, Comment => Comment
  def self.verdict_call_and_verify_success(client, log, verdict_id, comment_to_put)
    super
  end

end
