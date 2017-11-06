require_relative '../../base_classes/endpoints/base_class_for_put_id'

require_relative '../../../rest_api/data/post'

class PutPostsId < BaseClassForPutId

  Contract ExampleRestClient, Post => [Post, Any]
  def self.call_and_return_payload(client, post)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Post => Post
  def self.verdict_call_and_verify_success(client, log, verdict_id, post_to_put)
    super
  end

end
