require_relative '../../base_classes/endpoints/base_class_for_delete_id'

require_relative '../../../rest_api/data/todo'

class DeleteTodosId < BaseClassForDeleteId

  Contract ExampleRestClient, Todo => nil
  def self.call_and_return_payload(client, todo)
    super
  end

  Contract ExampleRestClient, Log, String, Todo => nil
  def self.verdict_call_and_verify_success(client, log, verdict_id, todo)
    super
  end

end
