require_relative 'base_class_for_data'

require_relative '../data/geo'

class Comment < BaseClassForData

  FIELDS = Set.new([
      :postId,
      :id,
      :name,
      :email,
      :body,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :geo,
      :commentId,
      :company

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    self.geo = Geo.new(self.geo) unless self.geo.nil?
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Comment, self, 'First object is of class Comment')
      log.va_integer_positive?(verdict_id + ' - post id', self.postId, 'Comment post id')
      log.va_integer_positive?(verdict_id + ' - id', self.id, 'Comment id')
      log.va_string_not_empty?(verdict_id + ' - name', self.name, 'Comment name')
      log.va_string_not_empty?(verdict_id + ' - email', self.email, 'Comment email')
      log.va_string_not_empty?(verdict_id + ' - body', self.body, 'Comment body')
    end
  end

  def self.get_all(client)
    require_relative '../endpoints/users/get_users'
    GetComments.call(client)
  end

end
