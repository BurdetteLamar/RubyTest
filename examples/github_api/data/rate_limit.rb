require_relative '../base_classes/base_class_for_resource'

class RateLimit < BaseClassForResource

  FIELDS = Set.new([
      :resources,
      :rate,
  ])

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    self.resources = Resources.new(self.resources) unless self.resources.nil?
    self.rate = Rate.new(self.rate) unless self.rate.nil?
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    resources.verdict_valid?(log, verdict_id + ' - resources')
    rate.verdict_valid?(log, verdict_id + ' - rate')
  end

  def self.get(client)
    require_relative '../endpoints/get_rate_limit'
    GetRateLimit.call(client)
  end

  class Info < BaseClassForData

    FIELDS = Set.new([
        :limit,
        :remaining,
        :reset,
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
      message = format('%s is positive integer', field)
      log.verdict_assert_integer_positive?(verdict_id, value, message)
    end

    Contract Symbol => Any
    def self.invalid_value_for(field)
      # Have to cite the parameter to avoid RubyMine code inspection complaint.
      field
      # For all fields.
      0
    end

    # This is harmlessly redundant, but helps RubyMine code inspection.
    attr_accessor \
        :limit,
        :remaining,
        :reset
  end

  class Resources < BaseClassForData

    FIELDS = Set.new([
        :core,
        :search,
        :graphql
                     ])

    attr_accessor *FIELDS

    # Constructor.
    Contract Hash => nil
    def initialize(values = {})
      super(FIELDS, values)
      self.core = Core_.new(self.core) unless self.core.nil?
      self.search = Search.new(self.search) unless self.search.nil?
      self.graphql = Graphql.new(self.graphql) unless self.graphql.nil?
      nil
    end

    Contract Log, String => Bool
    def verdict_valid?(log, verdict_id)
      core.verdict_valid?(log, verdict_id + ' - core')
      search.verdict_valid?(log, verdict_id + ' - search')
      graphql.verdict_valid?(log, verdict_id + ' - graphql')
    end

    # This is harmlessly redundant, but helps RubyMine code inspection.
    attr_accessor \
        :core,
        :search,
        :graphql

  end

  # This is harmlessly redundant, but helps RubyMine code inspection.
  attr_accessor \
      :resources,
      :rate

  class Rate < Info
  end

  # Class name Core would conflict with Contracts::Core.
  class Core_ < Info
  end

  class Search < Info
  end

  class Graphql < Info
  end

end
