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

end