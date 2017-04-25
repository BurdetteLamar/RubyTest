require_relative '../base_classes/base_class_for_get'

require_relative '../../data/todo'

class GetTodos < BaseClassForGet

  Contract ExampleRestClient => [ArrayOf[Todo], ArrayOf[Hash]]
  def self.call_and_return_payload(client)
    super(client)
  end

  Contract ExampleRestClient, Log, String => ArrayOf[Todo]
  def self.verdict_call_and_verify_success(client, log, verdict_id)
    super(client, log, verdict_id)
  end

end
