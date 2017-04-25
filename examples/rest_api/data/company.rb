require_relative 'base_class_for_data'

class Company < BaseClassForData

  FIELDS = Set.new([
      :name,
      :catchPhrase,
      :bs,
  ])

  # # This is redundant, but it helps RubyMine code inspection.
  # attr_accessor \

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Company, self, 'First object is of class Company')
      log.va_string_not_empty?(verdict_id + ' - name', self.name, 'Company name')
      log.va_string_not_empty?(verdict_id + ' - catchPhrase', self.catchPhrase, 'Company catchPhrase')
      log.va_string_not_empty?(verdict_id + ' - bs', self.bs, 'Company bs')
    end
  end

end