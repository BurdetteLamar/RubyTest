require_relative '../../base_classes/endpoints/base_class_for_post'

require_relative '../../../rest_api/data/post'

class PostPosts < BaseClassForPost

  Contract ExampleRestClient, Post => [Post, Any]
  def self.call_and_return_payload(client, post)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Post => Post
  def self.verdict_call_and_verify_success(client, log, verdict_id, post)
    super
  end

end
