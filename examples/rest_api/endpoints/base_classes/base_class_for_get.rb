require_relative '../base_classes/base_class_for_rest_request'
require_relative '../../../../lib/helpers/object_helper'

class BaseClassForGet < BaseClassForRestRequest

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Get', '')
  end

  def self.call_and_return_payload(client)
    url_elements = [
        url_element.downcase
    ]
    payload = client.get(url_elements)
    objects = []
    payload_array = payload.respond_to?(:each_pair) ? [payload] : payload
    payload_array.each do |hash|
      rehash = HashHelper.rehash_to_symbol_keys(hash)
      obj = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
      objects.push(obj)
    end
    [objects, payload]
  end

  # def self.verdict_call_and_verify_success(client, log, verdict_id, keys)
  #   objects = []
  #   log.section(:rescue, :timestamp, :duration, :name => verdict_id) do
  #     log.verdict_nothing_raised?('%s - nothing raised' % verdict_id) do
  #       objects, payload = self.call_and_return_payload(client)
  #       log.section(:name => 'Evaluation') do
  #         payload_keys = ObjectHelper.key_set(payload)
  #         ExampleRestClient.verdict_payload_keys_valid_keys?(log, '%s - keys' % verdict_id, keys, payload_keys)
  #         v_id = '%s - get %s' % [verdict_id, self.data_class_name]
  #         object_class = ObjectHelper.get_class_for_class_name(self.data_class_name)
  #         object_class.verdict_data_objects_valid_keys?(log, v_id, objects, keys)
  #       end
  #     end
  #   end
  #   objects
  # end

end