require_relative '../../../lib/base_classes/base_class_for_data'

require_relative '../data/geo'

class Todo < BaseClassForData

  FIELDS = Set.new([
         :userId,
         :id,
         :title,
         :completed,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :userId,
      :completed

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Todo, self, 'First object is of class Todo')
      log.va_integer_positive?(verdict_id + ' - user id', self.userId, 'Todo user id')
      log.va_integer_positive?(verdict_id + ' - id', self.id, 'Todo id')
      log.va_string_not_empty?(verdict_id + ' - title', self.title, 'Todo title')
      log.va_boolean?(verdict_id + ' - completed', self.completed, 'Todo completed')
    end
  end

  def self.read(client, photo)
    require_relative '../endpoints/todos/get_todos_id'
    GetTodosId.call(client, photo)
  end

  def self.get_all(client)
    require_relative '../endpoints/todos/get_todos'
    GetTodos.call(client)
  end

end
