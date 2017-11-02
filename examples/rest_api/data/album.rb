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
      when [
          :id,
          :userId,
      ].include?(field)
        message = format('%s positive integer', field)
        log.verdict_assert_integer_positive?(verdict_id, value, message: message)
      when [
          :title,
      ].include?(field)
        message = format('%s length in range', field)
        log.verdict_assert_string_length_in_range?(verdict_id, TITLE_LENGTH_RANGE, value, message: message)
      else
        ArgumentError.new(field.inspect)
    end
  end

  def self.id_valid
    ID_MIN_VALUE
  end

  def self.id_invalid
    ID_MIN_VALUE - 1
  end

  def self.user_id_valid
    USER_ID_MIN_VALUE
  end

  def self.user_id_invalid
    USER_ID_MIN_VALUE - 1
  end

  def self.title_valid
    StringHelper.string_of_min_length(TITLE_LENGTH_RANGE)
  end

  def self.title_invalid
    StringHelper.string_too_short(TITLE_LENGTH_RANGE)
  end

end
