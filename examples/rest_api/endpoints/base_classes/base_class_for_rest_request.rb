require_relative '../../../../lib/base_class'

require_relative '../../rest_client'

class BaseClassForRestRequest

  Contract RestClient, Args[Any] => Any
  def self.call(client, *args)
    # Derived class must define self.call_and_return_payload.
    return_val, _ = self.call_and_return_payload(client, *args)
    return_val
  end

end
