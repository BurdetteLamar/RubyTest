# This class does not derive from BaseClass,
# because that would cause a circular dependency.
# But it still needs Contracts.

require 'contracts'

# Class to help in 'printf' debugging.
class DebugHelper

  include Contracts

  # Contract Any, Maybe[String] => nil
  def self.printf(data, name = data.class.to_s, description = '')
    size = data.respond_to?(:size) ? data.size : 1
    puts format('%s (size=%d) %s', name, size, description)
    case
      when data.respond_to?(:each_pair)
        # Hash-like.
        data.each_pair do |k, v|
          puts format('  %s => %s', k, v)
        end
      when data.respond_to?(:each_with_index)
        # Array-like or Set-like.
        data.each_with_index do |v, i|
          puts format('  %6d: %s', i, v)
        end
      else
        puts format('  %s', data.inspect)
    end
    nil
  end

end


