require_relative 'base_class_for_test'

require_relative '../endpoints/todos/get_todos'
require_relative '../endpoints/todos/get_todos_id'

require_relative '../data/todo'
require_relative '../../../lib/log/log'

class TodosTest < BaseClassForTest

  def test_get_todos

    prelude do |client, log|

      GetTodos.verdict_call_and_verify_success(client, log, 'get todos')

    end

  end

  def test_get_todos_id

    prelude do |client, log|

      todo_to_fetch = Todo.get_first(client)
      GetTodosId.verdict_call_and_verify_success(client, log, 'get todo', todo_to_fetch)
    end
  end

end
