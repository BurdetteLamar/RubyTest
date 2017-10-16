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

  Contract Log, Maybe[String] => nil
  # Log recursively, so that nested objects can log themselves.
  def log(log, section_name = self.class.name)
    log.section(section_name) do
      log_recursive(self, log)
    end
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    valid = true
    fields.each do |field|
      verdict_field_valid?(log, format('%s %s', verdict_id, field), field) && valid
    end
    valid
  end

  Contract Any, Any, ArrayOf[Symbol] => Bool
  # Compare recursively, so that nested objects are compared.
  def self.equal?(expected_obj, actual_obj, fields_to_ignore = [])
    if expected_obj.kind_of?(BaseClassForData)
      self.equal_recursive?(expected_obj, actual_obj, fields_to_ignore)
    else
      actual_obj == expected_obj
    end
  end

  Contract Log, String, Any, Any, String => Bool
  # Verify recursively, so that nested objects can verify themselves.
  def self.verdict_equal?(log, verdict_id, expected_obj, actual_obj, message)
    if expected_obj.kind_of?(BaseClassForData)
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
  def log_recursive(obj, log)
    return if obj.nil?
    unless obj.kind_of?(BaseClassForData)
      # Can't process it below;  just log it here.
      log.put_element('data', obj.to_s)
      return
    end
    obj.fields.each do |key|
      value = obj.send "#{key}"
      # Don't log nil.
      next if value.nil?
      case
        when value.respond_to?(:log)
          # This value is an object that can log itself.
          value.log(log)
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

  # Compare an object recursively,
  # giving special handling to nested objects.
  def self.equal_recursive?(expected_obj, actual_obj, fields_to_ignore)
    expected_obj.fields.each do |field|
      next if fields_to_ignore.include?(field)
      expected_value = expected_obj.send(field)
      next if expected_value.nil?
      actual_value = actual_obj.send(field)
      if expected_value.kind_of?(BaseClassForData)
        return false unless self.equal_recursive?(expected_value, actual_value, [])
      else
        return false unless actual_value == expected_value
      end
    end
    true
  end

  # Verify an object recursively,
  # giving special handling to nested objects.
  def self.verdict_equal_recursive?(log, verdict_id, expected_obj, actual_obj, message)
    verdict = true
    expected_obj.fields.each do |field|
      expected_value = expected_obj.send(field)
      # No expected value?  Skip it.
      next if expected_value.nil?
      actual_value = actual_obj.send(field)
      if expected_value.kind_of?(BaseClassForData)
        log.section(expected_value.class.name) do
          v_id = format('%s %s', verdict_id, field)
          self.verdict_equal_recursive?(log, v_id, expected_value, actual_value, message)
        end
      else
        verdict = log.verdict_assert_equal?('%s-%s' % [verdict_id, field.downcase], expected_value, actual_value, message) && verdict
      end
    end
    verdict
  end

  # This is an instance method, to allow a data object to call conveniently
  # (and omit the argument).
  # The optional argument can be used to specify the source as something other than self.
  Contract Any => Any
  def self.deep_clone(obj = self)
    # If obj is a scalar that cannot clone, return obj.
    # The expression obj.respond_to?(:clone) is not a reliable test for clonability,
    # because every object has :clone (but some raise an error if it's called).
    # So we explicate here.
    if [
        Bignum,
        FalseClass,
        Fixnum,
        NilClass,
        Symbol,
        TrueClass,
        DateTime,
        Float,
    ].include?(obj.class)
      return obj
    end
    # If obj is a scalar that can clone, return a clone of it.
    if [
        String,
    ].include?(obj.class)
      return obj.clone
    end
    # Ok, we need to make the deep clone.
    clone = ObjectHelper.instantiate_class_for_class_name(obj.class.name)
    case
      when obj.kind_of?(BaseClassForData)
        obj.fields.each do |field|
          old_value = obj.send(field)
          clone.send("#{field}=", self.deep_clone(old_value))
        end
      when obj.kind_of?(Array)
        obj.each do |old_value|
          clone.push(self.deep_clone(old_value))
        end
      when obj.kind_of?(Hash)
        obj.each_pair do |key, old_value|
          clone.store(key, self.deep_clone(old_value))
        end
      else
        raise NotImplementedError.new(obj.class.name)
    end
    clone
  end

end
