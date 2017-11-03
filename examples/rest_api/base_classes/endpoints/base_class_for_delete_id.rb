require_relative '../base_class_for_endpoint'

class BaseClassForDeleteId < BaseClassForEndpoint

  def self.call_and_return_payload(client, object_to_delete)
    url_elements = [
        url_element.downcase,
        object_to_delete.id.to_s,
    ]
    client.delete(url_elements)
    nil
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_delete)
    # Some verdicts should fail, because JSONplaceholder will not actually delete the instance.
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      payload = self.call(client, object_to_delete)
      log.section('Evaluation') do
        log.verdict_assert_nil?('payload nil', payload)
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        klass.verdict_not_exist?(client, log, verdict_id, object_to_delete)
      end
      return payload
    end
  end

  private

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Delete', '').sub('Id', '')
  end

end