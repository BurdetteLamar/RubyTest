require_relative '../base_classes/base_class_for_resource'

class Comment < BaseClassForResource

  FIELDS = Set.new([
      :postId,
      :id,
      :name,
      :email,
      :body,
  ])

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Comment, self, 'First object is of class Comment')
      log.verdict_assert_integer_positive?(verdict_id + ' - post id', self.postId, 'Comment post id')
      log.verdict_assert_integer_positive?(verdict_id + ' - id', self.id, 'Comment id')
      log.verdict_assert_string_not_empty?(verdict_id + ' - name', self.name, 'Comment name')
      log.verdict_assert_string_not_empty?(verdict_id + ' - email', self.email, 'Comment email')
      log.verdict_assert_string_not_empty?(verdict_id + ' - body', self.body, 'Comment body')
    end
  end

end
