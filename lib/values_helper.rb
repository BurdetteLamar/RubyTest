require 'contracts'

class ValuesHelper

  include Contracts

  # Contract value for non-negative integer.
  # Using casing that agrees with other contract values,
  # which RubyMine did not like, so here's the suppressing pragma.
  # noinspection RubyConstantNamingConvention
  PosInteger = And[Not[Neg], Integer]

  Contract PosInteger, Maybe[String] => String
  # Return a string of the given size.
  # Use trimmed or extended base_string, which defaults to 'x'.
  def self.string_of_length(size, base_string = 'x')
    raise ArgumentError.new('Size < 0: %d' % size) if size < 0
    case
      when size == 0
        return ''
      when base_string.nil?
        return 'x' * size
      when base_string.size > size
        # Trim.
        return base_string[0..size-1]
      else
        # Extend.
        s = base_string
        while s.size < size
          s = s * 2
        end
        return s[0..size-1]
    end
  end

  Contract Range, Maybe[String] => Maybe[String]
  # Return a string of minimum length.
  # Use trimmed or extended base_string, which defaults to 'x'.
  def self.string_of_min_length(range, base_string = nil)
    self.string_of_length(range.first, base_string)
  end

  Contract Range, Maybe[String] => String
  # Return a string of maximum length.
  # Use trimmed or extended base_string, which defaults to 'x'.
  def self.string_of_max_length(range, base_string = nil)
    self.string_of_length(range.last, base_string)
  end

  Contract Range, Maybe[String] => Maybe[String]
  # Return a string that's just out of lower range.
  # Use trimmed or extended base_string, which defaults to 'x'.
  def self.string_too_short(range, base_string=nil)
    return nil if range.first == 0
    self.string_of_length(range.first - 1, base_string)
  end

  Contract Range, Maybe[String] => Maybe[String]
  # Return a string that's just out of upper range.
  # Use trimmed or extended base_string, which defaults to 'x'.
  def self.string_too_long(range, base_string=nil)
    self.string_of_length(range.last + 1, base_string)
  end

  Contract Range, Maybe[String] => HashOf[Symbol, Maybe[String]]
  # Return strings of maximum and minimum length for range.
  def self.strings_in_range(range, base_string=nil)
    {
        :max_length => self.string_of_max_length(range, base_string),
        :min_length => self.string_of_min_length(range, base_string),
    }
  end

  Contract Range, Maybe[String] => HashOf[Symbol, Maybe[String]]
  # Return string out of length range.
  def self.strings_out_of_range(range, base_string=nil)
    values = {
        :too_short => self.string_too_short(range, base_string),
        :too_long => self.string_too_long(range, base_string),
    }
    values.delete(:too_short) unless values.fetch(:too_short)
    values
  end

end