require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/todos/delete_todos_id'
require_relative '../endpoints/todos/get_todos'
require_relative '../endpoints/todos/get_todos_id'
require_relative '../endpoints/todos/post_todos'
require_relative '../endpoints/todos/put_todos_id'

class TodosTest < BaseClassForTest

  def test_delete_todos_id

    prelude do |client, log|
      log.section('Test DeleteTodosId') do
        todo_to_delete = nil
        log.section('Get a todo to delete') do
          todo_to_delete = Todo.get_first(client)
        end
        log.section('Delete the todo') do
          DeleteTodosId.verdict_call_and_verify_success(client, log, :delete_todo, todo_to_delete)
        end
      end
    end
  end

  def test_get_todos

    prelude do |client, log|
      log.section('Test GetTodos') do

        all_todos = nil

        log.section('GetTodos with no query') do
          all_todos = GetTodos.verdict_call_and_verify_success(client, log, :no_query)
        end

        log.section('GetTodos with simple query') do
          todo = all_todos.first
          query_elements = {
              :userId => todo.userId,
          }
          expected_todos = all_todos.select { |p| p.userId == todo.userId }
          actual_todos = GetTodos.call(client, query_elements)
          if log.verdict_assert_equal?(:count_for_simple_query, expected_todos.size, actual_todos.size)
            (0...expected_todos.size).each do |i|
              expected_todo = expected_todos[i]
              actual_todo = actual_todos[i]
              v_id = format('with_simple_query_%d', i).to_sym
              Todo.verdict_equal?(log, v_id, expected_todo, actual_todo)
            end
          end
        end

        log.section('GetTodos with complex query') do
          todo = all_todos.first
          query_elements = {
              :userId => todo.userId,
              :title => todo.title,
          }
          expected_todos = all_todos.select { |p| (p.userId == todo.userId) && (p.title == todo.title) }
          actual_todos = GetTodos.call(client, query_elements)
          if log.verdict_assert_equal?(:count_for_complex_query, expected_todos.size, actual_todos.size)
            (0...expected_todos.size).each do |i|
              expected_todo = expected_todos[i]
              actual_todo = actual_todos[i]
              v_id = format('with_complex_query_%d', i).to_sym
              Todo.verdict_equal?(log, v_id, expected_todo, actual_todo)
            end
          end
        end

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
          GetTodosId.verdict_call_and_verify_success(client, log, :get_todo, todo_to_fetch)
        end
      end
    end

  end

  def test_post_todos

    prelude do |client, log|
      log.section('Test PostTodos') do
        todo_to_create = Todo.new(
            :userId => 1,
            :id => nil,
            :title => 'New title',
            :completed => false,
        )
        PostTodos.verdict_call_and_verify_success(client, log, :todo_to_create, todo_to_create)
      end
    end

  end

  def test_put_todos_id

    prelude do |client, log|
      log.section('Test PutTodosId') do
        todo_to_update = nil
        log.section('Get a todo to update') do
          todo_original = Todo.get_first(client)
          todo_to_update = todo_original.clone
        end
        log.section('Put the modifications') do
          todo_to_update.title = 'New title'
          todo_to_update.completed = true
          PutTodosId.verdict_call_and_verify_success(client, log, :todo_to_update, todo_to_update)
        end
      end

    end

  end

end

