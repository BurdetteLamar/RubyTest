require_relative '../../base_classes/endpoints/base_class_for_get_id'

require_relative '../../../rest_api/data/album'

class GetAlbumsId < BaseClassForGetId

  Contract ExampleRestClient, Album => [Album, Hash]
  def self.call_and_return_payload(client, album)
    super
  end

  Contract ExampleRestClient, Log, String, Album => Album
  def self.verdict_call_and_verify_success(client, log, verdict_id, album)
    super
  end

end
