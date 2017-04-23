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

  def self.verdict_call_and_verify_success(client, log, verdict_id)
    objects = []
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      objects= self.call(client)
      log.section('Evaluation') do
        object = objects.first
        log.put_element('data', {:fetched_object_count => objects.size})
        object.log(log, 'First fetched ' + data_class_name)
        object.verdict_valid?(log, verdict_id)
      end
      return objects
    end
    objects
  end

end