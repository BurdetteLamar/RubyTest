require 'contracts'

class ValuesHelper

  include Contracts

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

  Contract Range, Maybe[String] => Or[String, nil]
  # Return a string of minimum length.
  def self.string_of_min_length(range, base_string = nil)
    self.string_of_length(range.first, base_string)
  end

  Contract Range, Maybe[String] => String
  # Return a string of maximum length.
  def self.string_of_max_length(range, base_string = nil)
    self.string_of_length(range.last, base_string)
  end

end