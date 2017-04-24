require_relative 'base_class_for_data'

require_relative '../data/address'
require_relative '../data/company'

class User < BaseClassForData

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
      :address

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    self.address = Address.new(self.address) unless self.address.nil?
    self.company = Company.new(self.company) unless self.company.nil?
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', User, self, 'First object is of class User')
      log.va_integer_positive?(verdict_id + ' - id', self.id, 'User id')
      log.va_string_not_empty?(verdict_id + ' - name', self.name, 'User name')
      log.va_string_not_empty?(verdict_id + ' - username', self.username, 'User username')
      log.va_string_not_empty?(verdict_id + ' - email', self.email, 'User email')
      log.va_string_not_empty?(verdict_id + ' - phone', self.phone, 'User phone')
      log.va_string_not_empty?(verdict_id + ' - website', self.website, 'User website')
      address.verdict_valid?(log, verdict_id + ' - address')
      company.verdict_valid?(log, verdict_id + ' - company')
    end
  end

  def self.get_all(client)
    require_relative '../endpoints/users/get_users'
    GetUsers.call(client)
  end

end
