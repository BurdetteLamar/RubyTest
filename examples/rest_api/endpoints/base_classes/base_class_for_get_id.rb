require_relative '../base_classes/base_class_for_rest_request'
require_relative '../../../../lib/helpers/object_helper'

class BaseClassForGetId < BaseClassForRestRequest

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Get', '').sub('Id', '')
  end

  def self.call_and_return_payload(client, object_to_fetch)
    url_elements = [
        url_element.downcase,
        object_to_fetch.id.to_s,
    ]
    payload = client.get(url_elements)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    object_fetched = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
    [object_fetched, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_fetch)
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      object_fetched = self.call(client, object_to_fetch)
      log.section('Evaluation') do
        object_fetched.log(log, 'Fetched ' + data_class_name)
        Album.verdict_equal?(log, data_class_name, object_to_fetch, object_fetched, 'Fetched')
      end
      return object_fetched
    end
  end

end