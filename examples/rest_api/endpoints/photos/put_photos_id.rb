require_relative '../../base_classes/endpoints/base_class_for_put_id'

require_relative '../../../rest_api/data/photo'

class PutPhotosId < BaseClassForPutId

  Contract ExampleRestClient, Photo => [Photo, Any]
  def self.call_and_return_payload(client, photo)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Photo => Photo
  def self.verdict_call_and_verify_success(client, log, verdict_id, photo_to_put)
    super
  end

end
