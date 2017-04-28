require_relative '../base_classes/base_class_for_post'

require_relative '../../../rest_api/data/album'

class PostAlbums < BaseClassForPost

  Contract ExampleRestClient, Album => [Album, Any]
  def self.call_and_return_payload(client, album)
    super
  end

  Contract ExampleRestClient, Log, String, Album => Album
  def self.verdict_call_and_verify_success(client, log, verdict_id, album)
    super
  end

end
