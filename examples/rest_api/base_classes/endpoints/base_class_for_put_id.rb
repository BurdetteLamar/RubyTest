require_relative '../base_class_for_endpoint'

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
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      object_put = self.call(client, object_to_put)
      log.section('Evaluation') do
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        v_id = [verdict_id, data_class_name.to_sym, :put]
        klass.verdict_equal?(log, v_id, object_to_put, object_put)
        # The JSONPlaceholder does not actually modify itself,
        # and so the following verdict would fail.
        # object_fetched = klass.read(client, object_to_put)
        # v_id = [verdict_id, data_class_name.to_sym, :fetched]
        # klass.verdict_equal?(log, v_id, object_to_put, object_fetched)
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
