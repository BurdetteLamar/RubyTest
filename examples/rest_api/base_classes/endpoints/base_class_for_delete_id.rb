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
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      payload = self.call(client, object_to_delete)
      log.section('Evaluation') do
        v_id = [verdict_id, :payload_nil]
        log.verdict_assert_nil?(v_id, payload)
        # The JSONPlaceholder does not actually modify itself,
        # and so the following verdict would fail.
        # klass = ObjectHelper.get_class_for_class_name(data_class_name)
        # v_id = [verdict_id, :not_exist]
        # klass.verdict_not_exist?(client, log, v_id, object_to_delete)
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