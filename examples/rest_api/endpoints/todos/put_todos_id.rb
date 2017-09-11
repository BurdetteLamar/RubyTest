require_relative '../../base_classes/endpoints/base_class_for_put_id'

require_relative '../../../rest_api/data/todo'

class PutTodosId < BaseClassForPutId

  Contract ExampleRestClient, Todo => [Todo, Any]
  def self.call_and_return_payload(client, todo)
    super
  end

  Contract ExampleRestClient, Log, String, Todo => Todo
  def self.verdict_call_and_verify_success(client, log, verdict_id, todo_to_put)
    super
  end

end
