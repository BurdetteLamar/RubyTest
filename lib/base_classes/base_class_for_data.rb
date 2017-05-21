require 'set'

require_relative '../../lib/log/log'

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

  Contract Log, String => nil
  # Log recursively, so that nested objects can log themselves.
  def log(log, comment = self.name)
    log_recursive(self, log, comment)
    nil
  end

  Contract Any, Any => Bool
  # Compare recursively, so that nested objects are compared.
  def self.equal?(expected_obj, actual_obj)
    if expected_obj.kind_of?(self.class)
      self.equal_recursive?(expected_obj, actual_obj)
    else
      actual_obj == expected_obj
    end
  end

  Contract Log, String, Any, Any, String => Bool
  # Verify recursively, so that nested objects can verify themselves.
  def self.verdict_equal?(log, verdict_id, expected_obj, actual_obj, message)
    if expected_obj.kind_of?(self.class)
      self.verdict_equal_recursive?(log, verdict_id, expected_obj, actual_obj, message)
    else
      log.verdict_assert_equal?(verdict_id, expected_obj, actual_obj, message)
    end
  end

  Contract None => Hash
  def to_hash
    hash = {}
    fields.each do |key|
      value = send "#{key}"
      next if value.nil?
      value = value.to_hash if value.respond_to?(:to_hash)
      hash[key] = value
    end
    hash
  end

  private

  # Log an object recursively,
  # giving special handling to nested objects.
  def log_recursive(obj, log, comment = obj.name)
    return if obj.nil?
    unless obj.kind_of?(self.class)
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

  # Compare an object recursively,
  # giving special handling to nested objects.
  def self.equal_recursive?(expected_obj, actual_obj)
    expected_obj.fields do |field|
      expected_value = expected_obj.send(field)
      next if expected_value.nil?
      actual_value = actual_obj.send(field)
      if actual_obj.kind_of?(self.class)
        self.equal_recursive?(expected_obj, actual_obj)
      else
        actual_value == expected_value
      end
    end
  end

  # Verify an object recursively,
  # giving special handling to nested objects.
  def self.verdict_equal_recursive?(log, verdict_id, expected_obj, actual_obj, message)
    verdict = true
    log.section(verdict_id) do
      expected_obj.fields.each do |field|
        expected_value = expected_obj.send(field)
        # No expected value?  Skip it.
        next if expected_value.nil?
        actual_value = actual_obj.send(field)
        if actual_obj.kind_of?(self.class)
          v_id = format('%s %s', verdict_id, field)
          self.verdict_equal_recursive?(log, v_id, expected_value, actual_value, message)
        else
          verdict = log.verdict_assert_equal?('%s-%s' % [verdict_id, field.downcase], expected_value, actual_value, message) && verdict
        end
      end
    end
    verdict
  end

end
