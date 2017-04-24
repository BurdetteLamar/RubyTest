require_relative 'base_class_for_data'

require_relative '../data/geo'

class Address < BaseClassForData

  FIELDS = Set.new([
      :street,
      :suite,
      :city,
      :zipcode,
      :geo,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :geo,
      :addressId,
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
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Address, self, 'First object is of class Address')
      log.va_string_not_empty?(verdict_id + ' - street', self.street, 'Address street')
      log.va_string_not_empty?(verdict_id + ' - suite', self.suite, 'Address suite')
      log.va_string_not_empty?(verdict_id + ' - city', self.city, 'Address city')
      log.va_string_not_empty?(verdict_id + ' - zipcode', self.zipcode, 'Address zipcode')
      geo.verdict_valid?(log, verdict_id + ' - geo')
    end
  end

end
