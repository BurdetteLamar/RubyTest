require_relative '../../../../lib/base_class'

require_relative '../../example_rest_client'

class BaseClassForRestRequest < BaseClass

  Contract ExampleRestClient, Args[Any] => Any
  def self.call(client, *args)
    # Derived class must define self.call_and_return_payload.
    return_val, _ = self.call_and_return_payload(client, *args)
    return_val
  end

end
