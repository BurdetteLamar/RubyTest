require 'contracts'

require_relative 'string_helper'

# Class to provide values for testing.
#
# Each method returns a hash of symbol/value pairs.
#
# Use hash.each_pair to loop through the hash.
#
# For each, construct a verdict using the value in the expected value,
# and the symbol in the verdict's message.
class ValuesHelper

  include Contracts

  Contract RangeOf[Integer] => HashOf[Symbol, Integer]
  # Return hash of integers in range.
  def self.integers_in_range(range)
    {
        :min => range.first,
        :max => range.last,
    }
  end

  Contract RangeOf[Integer] => HashOf[Symbol, Integer]
  # Return hash of integers not in range.
  def self.integers_not_in_range(range)
    {
        :too_small => range.first.pred,
        :too_large => range.last.succ,
    }
  end

  Contract Range, Maybe[String] => HashOf[Symbol, Maybe[String]]
  # Return hash of strings in range.
  def self.strings_in_range(range, base_string=nil)
    {
        :max_length => StringHelper.string_of_max_length(range, base_string),
        :min_length => StringHelper.string_of_min_length(range, base_string),
    }
  end

  Contract Range, Maybe[String] => HashOf[Symbol, Maybe[String]]
  # Return hash of strings out of range.
  def self.strings_not_in_range(range, base_string=nil)
    values = {
        :too_short => StringHelper.string_too_short(range, base_string),
        :too_long => StringHelper.string_too_long(range, base_string),
    }
    values.delete(:too_short) unless values.fetch(:too_short)
    values
  end

end