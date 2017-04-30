require_relative 'base_class_for_resource'

class Post < BaseClassForResource

  FIELDS = Set.new([
      :id,
      :userId,
      :title,
      :body,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :postId

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Post, self, 'First object is of class Post')
      log.va_integer_positive?(verdict_id + ' - id', self.id, 'Post id')
      log.va_integer_positive?(verdict_id + ' - user id', self.userId, 'Post user id')
      log.va_string_not_empty?(verdict_id + ' - title', self.title, 'Post title')
      log.va_string_not_empty?(verdict_id + ' - body', self.body, 'Post body')
    end
  end

end
