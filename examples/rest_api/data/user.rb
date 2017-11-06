require_relative '../base_classes/base_class_for_resource'

class User < BaseClassForResource

  FIELDS = Set.new([
      :id,
      :name,
      :username,
      :email,
      :address,
      :phone,
      :website,
      :company,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :address,
      :phone,
      :website

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    self.address = Address.new(self.address) unless self.address.nil?
    self.company = Company.new(self.company) unless self.company.nil?
    nil
  end

  Contract Log, VERDICT_ID => Bool
  def verdict_valid?(log, verdict_id)
    log.verdict_assert_integer_positive?([verdict_id, :id], self.id)
    log.verdict_assert_string_not_empty?([verdict_id, :name], self.name)
    log.verdict_assert_string_not_empty?([verdict_id, :username], self.username)
    log.verdict_assert_string_not_empty?([verdict_id, :email], self.email)
    log.verdict_assert_string_not_empty?([verdict_id, :phone], self.phone)
    log.verdict_assert_string_not_empty?([verdict_id, :website], self.website)
    address.verdict_valid?(log, [verdict_id, :address])
    company.verdict_valid?(log, [verdict_id, :company])
  end

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
      :company,
      :street,
      :suite,
      :city,
      :zipcode

    attr_accessor *FIELDS

    # Constructor.
    Contract Hash => nil
    def initialize(values = {})
      super(FIELDS, values)
      self.geo = Geo.new(self.geo) unless self.geo.nil?
      nil
    end

    Contract Log, VERDICT_ID => Bool
    def verdict_valid?(log, verdict_id)
      log.verdict_assert_string_not_empty?([verdict_id, :street], self.street, message: 'Address street')
      log.verdict_assert_string_not_empty?([verdict_id, :suite], self.suite, message: 'Address suite')
      log.verdict_assert_string_not_empty?([verdict_id, :city], self.city, message: 'Address city')
      log.verdict_assert_string_not_empty?([verdict_id, :zipcode], self.zipcode, message: 'Address zipcode')
      geo.verdict_valid?(log, [verdict_id, :geo])
    end

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

      Contract Log, VERDICT_ID => Bool
      def verdict_valid?(log, verdict_id)
        log.verdict_assert_in_delta?([verdict_id, :lat], 0, self.lat, 90, message: 'Geo lat')
        log.verdict_assert_in_delta?([verdict_id, :lng], 0, self.lng, 90, message: 'Geo lng')
      end

    end

  end

  class Company < BaseClassForData

    FIELDS = Set.new([
                         :name,
                         :catchPhrase,
                         :bs,
                     ])

    attr_accessor *FIELDS

    # Constructor.
    Contract Hash => nil
    def initialize(values = {})
      super(FIELDS, values)
    end

    Contract Log, VERDICT_ID => Bool
    def verdict_valid?(log, verdict_id)
      log.verdict_assert_string_not_empty?([verdict_id, :name], self.name, message: 'Company name')
      log.verdict_assert_string_not_empty?([verdict_id, :catchPhrase], self.catchPhrase, message: 'Company catchPhrase')
      log.verdict_assert_string_not_empty?([verdict_id, :bs], self.bs, message: 'Company bs')
    end

  end

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :catchPhrase,
      :bs

end
