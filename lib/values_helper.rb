require 'contracts'

class ValuesHelper

  include Contracts

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