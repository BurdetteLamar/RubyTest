require_relative '../base_classes/base_class_for_get_id'

require_relative '../../../rest_api/data/photo'

class GetPhotosId < BaseClassForGetId

  Contract ExampleRestClient, Photo => [Photo, Hash]
  def self.call_and_return_payload(client, photo)
    super(client, photo)
  end

  Contract ExampleRestClient, Log, String, Photo => Photo
  def self.verdict_call_and_verify_success(client, log, verdict_id, photo)
    super(client, log, verdict_id, photo)
  end

end
