require_relative '../base_classes/base_class_for_resource'

class Post < BaseClassForResource

  FIELDS = Set.new([
      :id,
      :userId,
      :title,
      :body,
  ])

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, VERDICT_ID => Bool
  def verdict_valid?(log, verdict_id)
    log.verdict_assert_integer_positive?([verdict_id, :id], self.id)
    log.verdict_assert_integer_positive?([verdict_id, :user_id], self.userId)
    log.verdict_assert_string_not_empty?([verdict_id, :title], self.title)
    log.verdict_assert_string_not_empty?([verdict_id, :body], self.body)
  end

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :postId

end
