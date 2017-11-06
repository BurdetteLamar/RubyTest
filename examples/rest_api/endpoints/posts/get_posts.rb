require_relative '../../base_classes/endpoints/base_class_for_get'

require_relative '../../data/post'

class GetPosts < BaseClassForGet

  Contract ExampleRestClient, Maybe[Hash] => [ArrayOf[Post], ArrayOf[Hash]]
  def self.call_and_return_payload(client, query_elements = {})
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Maybe[Hash] => ArrayOf[Post]
  def self.verdict_call_and_verify_success(client, log, verdict_id, query_elements = {})
    super
  end

end
