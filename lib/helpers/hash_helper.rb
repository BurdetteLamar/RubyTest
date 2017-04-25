require_relative '../base_classes/base_class'

class HashHelper < BaseClass

  Contract Hash, Hash => HashOf[Symbol => Hash]
  # Compare two hashes.
  # Returns a hash with keys +:ok+, +:missing+, +:unexpected+, +:changed+.
  def self.compare(expected, actual)
    result = {
        :missing => {},
        :unexpected => {},
        :changed => {},
        :ok => {},
    }
    expected.each_pair do |key_expected, value_expected|
      if actual.include?(key_expected)
        value_actual = actual[key_expected]
        if value_actual == value_expected
          result[:ok][key_expected] = value_expected
        else
          result[:changed][key_expected] = {:expected => value_expected, :actual => value_actual}
        end
      else
        result[:missing][key_expected] = value_expected
      end
    end
    actual.each_pair do |key_actual, value_actual|
      next if expected.include?(key_actual)
      result[:unexpected][key_actual] = value_actual
    end
    result
  end

  Contract Hash => Hash
  def self.rehash_to_symbol_keys(hash)
    rehash = {}
    hash.each_pair do |k, v|
      rehash.store(k.to_sym, v)
    end
  end

end

