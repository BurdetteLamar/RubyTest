require_relative '../../base_classes/endpoints/base_class_for_post'

require_relative '../../../rest_api/data/comment'

class PostComments < BaseClassForPost

  Contract ExampleRestClient, Comment => [Comment, Any]
  def self.call_and_return_payload(client, comment)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Comment => Comment
  def self.verdict_call_and_verify_success(client, log, verdict_id, comment)
    super
  end

end
