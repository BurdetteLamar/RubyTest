require_relative '../base_classes/base_class'

class SetHelper < BaseClass

  Contract Set, Set => HashOf[Symbol => Set]
  # Compare two sets.
  # Returns a hash with keys +:ok+, +:missing+, +:unexpected+.
  def self.compare(expected, actual)
    {
        :missing => expected - actual,
        :unexpected => actual - expected,
        :ok => expected & actual,
    }
  end

end

