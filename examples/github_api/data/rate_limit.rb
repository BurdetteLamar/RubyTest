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
      self.core = Core.new(self.core) unless self.core.nil?
      self.search = Search.new(self.search) unless self.search.nil?
      self.graphql = Graphql.new(self.graphql) unless self.graphql.nil?
      nil
    end

    Contract Log, String => Bool
    def verdict_field_valid?(log, verdict_id, field)
      value = self.send(field)
      value.verdict_valid?(log, format('%s - %s', verdict_id, field))
    end

    attr_accessor \
        :core,
        :search,
        :graphql

  end

  attr_accessor \
      :resources,
      :rate

  class Rate < Info
  end

  class Core < Info

  end

  class Search < Info

  end

  class Graphql < Info

  end

end
