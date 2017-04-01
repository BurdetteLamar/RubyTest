# This class does not derive from BaseClass,
# because that would cause a circular dependency.
# But it still needs Contracts.

require 'contracts'

# Class to help in debugging.
class DebugHelper

  include Contracts

  Contract Hash, Maybe[String] => nil
  def self.puts_hash(hash, name = 'Hash')
    puts name
    hash.each_pair do |k, v|
      puts format('  %s => %s', k, v)
    end
    nil
  end

end