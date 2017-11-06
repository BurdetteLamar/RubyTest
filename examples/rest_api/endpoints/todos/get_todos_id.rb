require_relative '../../base_classes/endpoints/base_class_for_get_id'

require_relative '../../../rest_api/data/todo'

class GetTodosId < BaseClassForGetId

  Contract ExampleRestClient, Todo => [Todo, Hash]
  def self.call_and_return_payload(client, todo)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, Todo => Todo
  def self.verdict_call_and_verify_success(client, log, verdict_id, todo)
    super
  end

end
