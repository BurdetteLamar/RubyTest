require_relative '../../base_classes/base_class_for_endpoint'

require_relative '../../data/label'

class DeleteLabelsName < BaseClassForEndpoint

  Contract GithubClient, Label, Maybe[Hash] => [nil, nil]
  def self.call_and_return_payload(client, label_to_delete, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'labels',
        label_to_delete.name,
    ]
    payload = client.delete(url_elements, query_elements)
    [payload, payload]
  end

  Contract GithubClient, Log, String, Label, Maybe[Hash] => nil
  def self.verdict_call_and_verify_success(client, log, verdict_id, label_to_delete, query_elements = {})
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      payload = self.call(client, label_to_delete, query_elements)
      log.section('Evaluation') do
        log.section('Payload empty') do
          v_id = Log.verdict_id(verdict_id, 'payload nil')
          log.verdict_assert_nil?(v_id, payload, 'Payload nil')
        end
        log.section('Label deleted') do
          v_id = Log.verdict_id(verdict_id, 'label deleted')
          Label.verdict_not_exist?(client, log, v_id, label_to_delete)
        end
      end
      return payload
    end
  end

end
