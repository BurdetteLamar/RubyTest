require_relative '../base_classes/base_class_for_rest_request'
# require_relative '../../../../lib/helpers/object_helper'

class BaseClassForPutId < BaseClassForRestRequest

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Put', '').sub('Id', '')
  end

  def self.call_and_return_payload(client, object_to_put)
    url_elements = [
        url_element.downcase,
        object_to_put.id.to_s,

    ]
    query_elements = []
    parameters = object_to_put.to_hash
    payload = client.put(url_elements, query_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    object_posted = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
    [object_posted, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_put)
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      object_to_put.log(log, '%s to put' % object_to_put.class.name)
      object_put = self.call(client, object_to_put)
      log.section('Evaluation') do
        object_put.log(log, 'Put ' + data_class_name)
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        klass.verdict_equal?(log, 'Put', object_to_put, object_put, 'Put')
        object_fetched = klass.read(client, object_to_put)
        klass.verdict_equal?(log, 'Fetched', object_to_put, object_fetched, 'Fetched')
      end
      return object_put
    end
  end

end