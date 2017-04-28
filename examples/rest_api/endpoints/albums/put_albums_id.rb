require_relative '../base_classes/base_class_for_put_id'

require_relative '../../../rest_api/data/album'

class PutAlbumsId < BaseClassForPutId

  Contract ExampleRestClient, Album => [Album, Any]
  def self.call_and_return_payload(client, album)
    super
  end

  Contract ExampleRestClient, Log, String, Album => Album
  def self.verdict_call_and_verify_success(client, log, verdict_id, album_to_put)
    super
  end

end
