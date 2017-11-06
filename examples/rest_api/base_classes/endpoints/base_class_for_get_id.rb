require_relative '../base_class_for_endpoint'

class BaseClassForGetId < BaseClassForEndpoint

  def self.call_and_return_payload(client, object_to_fetch)
    url_elements = [
        url_element.downcase,
        object_to_fetch.id.to_s,
    ]
    payload = client.get(url_elements)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    object_got = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
    [object_got, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_get)
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      object_got = self.call(client, object_to_get)
      log.section('Evaluation') do
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        v_id = [verdict_id, data_class_name.to_sym]
        klass.verdict_equal?(log, v_id, object_to_get, object_got)
      end
      return object_got
    end
  end

  private

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Get', '').sub('Id', '')
  end

end