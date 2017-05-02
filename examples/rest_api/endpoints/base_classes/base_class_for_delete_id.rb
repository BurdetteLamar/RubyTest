require_relative '../base_classes/base_class_for_endpoint'
require_relative '../../../../lib/helpers/object_helper'

class BaseClassForDeleteId < BaseClassForEndpoint

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Delete', '').sub('Id', '')
  end

  def self.call_and_return_payload(client, object_to_delete)
    url_elements = [
        url_element.downcase,
        object_to_delete.id.to_s,
    ]
    client.delete(url_elements)
    nil
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_delete)
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      object_to_delete.log(log, data_class_name + ' to delete')
      payload = self.call(client, object_to_delete)
      log.section('Evaluation') do
        log.va_nil?('payload nil', payload, 'Payload nil')
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        klass.verdict_not_exist?(client, log, verdict_id, object_to_delete)
      end
      return payload
    end
  end

end