require_relative '../base_classes/base_class_for_get_id'

require_relative '../../../rest_api/data/post'

class GetPostsId < BaseClassForGetId

  Contract ExampleRestClient, Post => [Post, Hash]
  def self.call_and_return_payload(client, post)
    super(client, post)
  end

  Contract ExampleRestClient, Log, String, Post => Post
  def self.verdict_call_and_verify_success(client, log, verdict_id, post)
    super(client, log, verdict_id, post)
  end

end
