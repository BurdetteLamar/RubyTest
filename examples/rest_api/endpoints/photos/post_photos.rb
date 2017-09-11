require_relative '../../base_classes/endpoints/base_class_for_post'

require_relative '../../../rest_api/data/photo'

class PostPhotos < BaseClassForPost

  Contract ExampleRestClient, Photo => [Photo, Any]
  def self.call_and_return_payload(client, photo)
    super
  end

  Contract ExampleRestClient, Log, String, Photo => Photo
  def self.verdict_call_and_verify_success(client, log, verdict_id, photo)
    super
  end

end
