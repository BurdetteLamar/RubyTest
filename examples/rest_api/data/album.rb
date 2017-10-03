require_relative '../base_classes/base_class_for_resource'

require_relative '../../../lib/helpers/string_helper'

class Album < BaseClassForResource

  FIELDS = Set.new([
      :id,
      :userId,
      :title,
  ])

  attr_accessor *FIELDS

  ID_MIN_VALUE = 1
  USER_ID_MIN_VALUE = 1
  TITLE_LENGTH_RANGE = (1..50)

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, String, Symbol => Bool
  def verdict_field_valid?(log, verdict_id, field)
    value = self.send(field)
    case
      when
        [
            :id,
            :userId,
        ].include?(field)
        log.verdict_assert_integer_positive?(verdict_id, value, format('%s positive integer', field))
      when
        [
            :title,
        ].include?(field)
        log.verdict_assert_string_not_empty?(verdict_id, value, format('%s nonempty string', field))
      else
        ArgumentError.new(field.inspect)
    end
  end

  def self.valid_id
    ID_MIN_VALUE
  end

  def self.invalid_id
    ID_MIN_VALUE - 1
  end

  def self.valid_user_id
    USER_ID_MIN_VALUE
  end

  def self.invalid_user_id
    USER_ID_MIN_VALUE - 1
  end

  def self.valid_title
    StringHelper.string_of_min_length(TITLE_LENGTH_RANGE)
  end

  def self.invalid_title
    StringHelper.string_too_short(TITLE_LENGTH_RANGE)
  end

end
