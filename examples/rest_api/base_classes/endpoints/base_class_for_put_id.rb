require_relative '../base_class_for_endpoint'
# require_relative '../../../../lib/helpers/object_helper'

class BaseClassForPutId < BaseClassForEndpoint

  def self.call_and_return_payload(client, object_to_put)
    url_elements = [
        url_element.downcase,
        object_to_put.id.to_s,

    ]
    parameters = object_to_put.to_hash
    payload = client.put(url_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    object_posted = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
    [object_posted, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_put)
    # Some verdicts should fail, because JSONplaceholder will not actually update the instance.
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

  private

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Put', '').sub('Id', '')
  end

end
