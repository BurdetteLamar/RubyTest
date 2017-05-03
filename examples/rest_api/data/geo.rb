require_relative '../../../lib/base_classes/base_class_for_data'

class Geo < BaseClassForData

  FIELDS = Set.new([
      :lat,
      :lng,
  ])
  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :lat,
      :lng

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    self.lat = self.lat.to_f
    self.lng = self.lng.to_f
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Geo, self, 'First object is of class Geo')
      log.verdict_assert_in_delta?(verdict_id + ' - lat', 0, self.lat, 90, 'Geo lat')
      log.verdict_assert_in_delta?(verdict_id + ' - lng', 0, self.lng, 90, 'Geo lng')
    end
  end

end
