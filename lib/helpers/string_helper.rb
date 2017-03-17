require 'contracts'

class StringHelper

  include Contracts

  DEFAULT_BASE_STRING = 'x'

  # Contract value for non-negative integer.
  # Using casing that agrees with other contract values,
  # which RubyMine did not like, so here's the suppressing pragma.
  # noinspection RubyConstantNamingConvention
  PosInteger = And[Not[Neg], Integer]

  Contract PosInteger, Maybe[String] => String
  # Return a string of the given length.
  # Use trimmed or extended base_string.
  def self.string_of_length(length, base_string = DEFAULT_BASE_STRING)
    raise ArgumentError.new('length < 0: %d' % length) if length < 0
    case
      when length == 0
        return ''
      when base_string.nil?
        return DEFAULT_BASE_STRING * length
      when base_string.length > length
        # Trim.
        return base_string[0..length-1]
      else
        # Extend.
        s = base_string
        while s.length < length
          s = s * 2
        end
        return s[0..length-1]
    end
  end

  Contract Range, Maybe[String] => Maybe[String]
  # Return a string of minimum length.
  # Use trimmed or extended base_string.
  def self.string_of_min_length(range, base_string = nil)
    self.string_of_length(range.first, base_string)
  end

  Contract Range, Maybe[String] => String
  # Return a string of maximum length.
  # Use trimmed or extended base_string.
  def self.string_of_max_length(range, base_string = nil)
    self.string_of_length(range.last, base_string)
  end

  Contract Range, Maybe[String] => Maybe[String]
  # Return a string that's just out of lower range.
  # Use trimmed or extended base_string.
  def self.string_too_short(range, base_string=nil)
    self.string_of_length(range.first - 1, base_string)
  end

  Contract Range, Maybe[String] => Maybe[String]
  # Return a string that's just out of upper range.
  # Use trimmed or extended base_string.
  def self.string_too_long(range, base_string=nil)
    self.string_of_length(range.last + 1, base_string)
  end

end