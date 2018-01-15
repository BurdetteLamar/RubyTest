require_relative '../../base_classes/base_class_for_endpoint'

require_relative '../../../data/label'

class PatchLabelsName < BaseClassForEndpoint

  Contract ApiClient, Label, Label, Maybe[Hash] => [Label, Any]
  def self.call_and_return_payload(client, label_target, label_source, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'labels',
        label_target.name,
    ]
    parameters = {
        :color => label_source.color,
        :name => label_source.name,
    }
    payload = client.patch(url_elements, query_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    label_updated = Label.new(rehash)
    [label_updated, payload]
  end

  Contract ApiClient, VERDICT_ID, Label, Label, Maybe[Hash] => Label
  def self.verdict_call_and_verify_success(client, verdict_id, label_target, label_source, query_elements = {})
    log = client.log
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      label_updated = self.call(client, label_target, label_source, query_elements)
      log.section('Evaluation') do
        log.section('Returned label correct') do
          v_id = [verdict_id, :updated_label]
          Label.verdict_equal?(log, v_id, label_target, label_source, 'Updated label correct')
        end
        log.section('Label updated') do
          fetched_label = label_updated.read(client,)
          v_id = [verdict_id, :fetched_label]
          Label.verdict_equal?(log, v_id, label_source, fetched_label, 'Fetched label correct')
        end
      end
      return label_updated
    end
  end

end
