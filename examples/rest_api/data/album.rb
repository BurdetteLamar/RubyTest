require_relative 'base_class_for_data'

class Album < BaseClassForData

  FIELDS = Set.new([
      :id,
      :userId,
      :title,
  ])

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Album, self, 'First object is an Album')
      log.verdict_assert_operator?(verdict_id + ' - positive id', 0, :<, self.id, 'Album id is positive')
      log.verdict_assert_operator?(verdict_id + ' - positive user-id', 0, :<, self.id, 'Album user-id is positive')
      if log.verdict_assert_instance_of?(verdict_id + ' - title class', String, self.title, 'Album title is a String')
        log.verdict_refute_empty?(verdict_id + ' - non-empty title', self.title, 'Album title is not empty')
      end
    end
  end

end