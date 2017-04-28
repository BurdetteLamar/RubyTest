require_relative '../base_classes/base_class_for_get'

require_relative '../../data/photo'

class GetPhotos < BaseClassForGet

  Contract ExampleRestClient => [ArrayOf[Photo], ArrayOf[Hash]]
  def self.call_and_return_payload(client)
    super
  end

  Contract ExampleRestClient, Log, String => ArrayOf[Photo]
  def self.verdict_call_and_verify_success(client, log, verdict_id)
    super
  end

end
