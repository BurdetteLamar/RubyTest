require_relative '../base_classes/base_class_for_get'

require_relative '../../data/comment'

class GetComments < BaseClassForGet

  Contract ExampleRestClient => [ArrayOf[Comment], ArrayOf[Hash]]
  def self.call_and_return_payload(client)
    super
  end

  Contract ExampleRestClient, Log, String => ArrayOf[Comment]
  def self.verdict_call_and_verify_success(client, log, verdict_id)
    super
  end

end
