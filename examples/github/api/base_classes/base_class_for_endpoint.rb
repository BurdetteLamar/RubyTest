require_relative '../../../../lib/base_classes/base_class'
require_relative '../../../../lib/helpers/object_helper'

require_relative '../api_client'

class BaseClassForEndpoint < BaseClass

  Contract ApiClient, Args[Any] => Any
  def self.call(client, *args)
    # Derived class must define self.call_and_return_payload.
    return_val, _ = self.call_and_return_payload(client, *args)
    return_val
  end

end
