require_relative '../../base_classes/endpoints/base_class_for_delete_id'

require_relative '../../../rest_api/data/album'

class DeleteAlbumsId < BaseClassForDeleteId

  Contract ExampleRestClient, Album => nil
  def self.call_and_return_payload(client, album)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Album => nil
  def self.verdict_call_and_verify_success(client, log, verdict_id, album)
    super
  end

end
