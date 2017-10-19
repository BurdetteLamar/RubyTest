require_relative '../../base_classes/base_class_for_endpoint'

require_relative '../../data/label'

class PatchLabelsName < BaseClassForEndpoint

  Contract GithubClient, Label, Maybe[Hash] => [Label, Any]
  def self.call_and_return_payload(client, label_to_update, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'labels',
        label_to_update.name,
    ]
    parameters = {
        :color => label_to_update.color,
    }
    payload = client.patch(url_elements, query_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    label_updated = Label.new(rehash)
    [label_updated, payload]
  end

  Contract GithubClient, Log, String, Label, Maybe[Hash] => Label
  def self.verdict_call_and_verify_success(client, log, verdict_id, label_to_update, query_elements = {})
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      label_updated = self.call(client, label_to_update, query_elements)
      log.section('Evaluation') do
        log.section('Updated label correct') do
          v_id = Log.verdict_id(verdict_id, 'updated label')
          Label.verdict_equal?(log, v_id, label_to_update, label_updated, 'Updated label correct')
        end
        log.section('Returned label valid') do
          v_id = Log.verdict_id(verdict_id, 'returned label')
          label_updated.verdict_valid?(log, v_id)
        end
        log.section('Fetched label correct') do
          fetched_label = Label.read(client, label_to_update)
          v_id = Log.verdict_id(verdict_id, 'fetched label')
          Label.verdict_equal?(log, v_id, label_to_update, fetched_label, 'Fetched label correct')
        end
      end
      return label_updated
    end
  end

end
