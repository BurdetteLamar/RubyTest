require_relative '../base_classes/base_class_for_resource'

class Album < BaseClassForResource

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

end
