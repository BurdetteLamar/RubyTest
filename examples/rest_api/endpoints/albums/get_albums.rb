require_relative '../base_classes/base_class_for_get'

require_relative '../../data/album'

class GetAlbums < BaseClassForGet

  Contract ExampleRestClient, Maybe[Hash] => [ArrayOf[Album], ArrayOf[Hash]]
  def self.call_and_return_payload(client, query_elements = {})
    super
  end

  Contract ExampleRestClient, Log, String, Maybe[Hash] => ArrayOf[Album]
  def self.verdict_call_and_verify_success(client, log, verdict_id, query_elements = {})
    super
  end

end
