require_relative '../base_class_for_endpoint'

class BaseClassForGet < BaseClassForEndpoint

  def self.call_and_return_payload(client, query_elements)
    url_elements = [
        url_element.downcase,
    ]
    payload = client.get(url_elements, query_elements)
    objects = []
    payload.each do |hash|
      rehash = HashHelper.rehash_to_symbol_keys(hash)
      obj = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
      objects.push(obj)
    end
    [objects, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, query_elements)
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      objects = self.call(client, query_elements)
      log.section('Evaluation') do
        object = objects.first
        log.put_element('data', {:fetched_object_count => objects.size})
        log.section('First fetched') do
          object.log(log)
        end
        v_id = [verdict_id, :valid]
        object.verdict_valid?(log, v_id)
      end
      return objects
    end
  end

  private

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Get', '')
  end

end