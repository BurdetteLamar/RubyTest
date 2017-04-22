require 'set'

require_relative '../../../lib/base_class'

class BaseClassForData < BaseClass

  # A derived class can call this method to initialize fields.
  Contract Set, Hash => nil
  def initialize(fields, values)
    @fields = fields
    case
      when values.respond_to?(:each_pair)
        # Hash of values for accessors.
        values.each_pair { |key, value| send("#{key}=", value) }
      when values.kind_of?(String)
        # Payload from a web method.
        raise NotImplementedError.new(values.inspect)
      else
        raise ArgumentError.new(values.inspect)
    end
    nil
  end

end