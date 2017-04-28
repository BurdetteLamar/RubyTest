require_relative '../base_classes/base_class_for_delete_id'

require_relative '../../../rest_api/data/photo'

class DeletePhotosId < BaseClassForDeleteId

  Contract ExampleRestClient, Photo => nil
  def self.call_and_return_payload(client, photo)
    super
  end

  Contract ExampleRestClient, Log, String, Photo => nil
  def self.verdict_call_and_verify_success(client, log, verdict_id, photo)
    super
  end

end
