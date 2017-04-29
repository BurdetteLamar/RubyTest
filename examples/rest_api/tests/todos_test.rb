require_relative 'base_class_for_test'

require_relative '../endpoints/todos/delete_todos_id'
require_relative '../endpoints/todos/get_todos'
require_relative '../endpoints/todos/get_todos_id'
require_relative '../endpoints/todos/post_todos'
require_relative '../endpoints/todos/put_todos_id'

require_relative '../data/todo'
require_relative '../../../lib/log/log'

class TodosTest < BaseClassForTest

  def test_delete_todos_id

    prelude do |client, log|
      log.section('Test DeleteTodos') do
        todo_to_delete = nil
        log.section('Get a todo to delete') do
          todo_to_delete = Todo.get_first(client)
        end
        log.section('Delete the todo') do
          # This should fail, because JSONplaceholder will not actually delete the todo.
          DeleteTodosId.verdict_call_and_verify_success(client, log, 'delete todo', todo_to_delete)
        end
      end
    end
  end

  def test_get_todos

    prelude do |client, log|
      log.section('Test GetTodos') do
        GetTodos.verdict_call_and_verify_success(client, log, 'get todos')
      end
    end

  end

  def test_get_todos_id

    prelude do |client, log|
      log.section('Test GetTodosId') do
        todo_to_fetch = nil
        log.section('Get a todo to fetch') do
          todo_to_fetch = Todo.get_first(client)
        end
        log.section('Fetch the todo') do
          GetTodosId.verdict_call_and_verify_success(client, log, 'get todo', todo_to_fetch)
        end
      end
    end

  end

  def test_post_todos

    prelude do |client, log|
      log.section('Test PostTodos') do
        todo_to_post = Todo.new(
            :userId => 1,
            :id => 1,
            :title => 'New title',
            :completed => false,
        )
        # This should fail, because JSONplaceholder will not actually create the todo.
        PostTodos.verdict_call_and_verify_success(client, log, 'todo to_create', todo_to_post)
      end
    end

  end

  def test_put_todos_id

    prelude do |client, log|
      log.section('Test PutTodos') do
        todo_to_put = nil
        log.section('Get a todo to put') do
          todo_original = Todo.get_first(client)
          todo_to_put = todo_original.clone
        end
        log.section('Put the modifications') do
          todo_to_put.title = 'New title'
          todo_to_put.completed = true
          # This should fail, because JSONplaceholder will not actually update the todo.
          PutTodosId.verdict_call_and_verify_success(client, log, 'Todo to put', todo_to_put)
        end
      end

    end

  end

end

