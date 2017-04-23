require 'set'

require_relative '../../../lib/base_class'

class BaseClassForData < BaseClass

  attr_accessor :fields

  # A derived class can call this method to initialize fields.
  Contract Set, Hash => nil
  def initialize(fields, values)
    self.fields = fields
    case
      when values.respond_to?(:each_pair)
        # Hash of values for accessors.
        values.each_pair { |key, value| send("#{key}=", value) }
      else
        raise ArgumentError.new(values.inspect)
    end
    nil
  end

  # A derived class can call this method to log an instance of itself.
  Contract Log, String => nil
  def log(log, comment = self.class.name)
    # Log recursively, so that nested objects can log themselves.
    log_recursive(self, log, comment)
    nil
  end

  # Log an object recursively,
  # giving special handling to nested objects.
  def log_recursive(obj, log, comment = obj.class.name)
    return if obj.nil?
    unless obj.respond_to?(:fields)
      # Can't process it below;  just log it here.
      log.put_element('data', obj.to_s)
      return
    end
    log.section(comment) do
      obj.fields.each do |key|
        value = obj.send "#{key}"
        # Don't log nil.
        next if value.nil?
        case
          when value.respond_to?(:log)
            # This value is an object that can log itself.
            value.log(log, key.to_s)
          when value.respond_to?(:each)
            # Log each element.
            log.section(key.to_s) do
              value.each do |x|
                self.log_recursive(x, log)
              end
            end
          else
            # Log here.
            log.put_element('data', {:field => key, :value => value})
        end
      end
    end
  end

end