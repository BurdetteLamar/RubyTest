require 'contracts'

require_relative '../helpers/debug_helper'

module Contracts
  class MethodHandler
    # Override this with two small (but important) changes.
    def validate_decorators!
      return if decorators.size == 1
      # Weird bug; thinks this method has 55 contracts!
      return if method_name == :psych_yaml_as
      # Original has #{name}, which is not defined; #{method_name} works.
      fail %{
Oops, it looks like method '#{method_name}' has multiple contracts:
#{decorators.map { |x| x[1][0].inspect }.join("\n")}

Did you accidentally put more than one contract on a single function, like so?

Contract String => String
Contract Num => String
def foo x
end

If you did NOT, then you have probably discovered a bug in this library.
Please file it along with the relevant code at:
https://github.com/egonSchiele/contracts.ruby/issues
      }
    end
  end

end
class BaseClass

  include Contracts



end

# TODO:  Make TestBaseClass.