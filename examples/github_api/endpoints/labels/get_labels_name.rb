require_relative '../../base_classes/base_class_for_endpoint'

require_relative '../../data/label'

class GetLabelsName < BaseClassForEndpoint

  Contract GithubClient, Label, Maybe[Hash] => [Label, Any]
  def self.call_and_return_payload(client, label_to_fetch, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'labels',
        label_to_fetch.name,
    ]
    payload = client.get(url_elements, query_elements)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    label = Label.new(rehash)
    [label, payload]
  end

  Contract GithubClient, Log, String, Label, Maybe[Hash] => Label
  def self.verdict_call_and_verify_success(client, log, verdict_id, label_to_fetch, query_elements = {})
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      label_fetched = self.call(client, label_to_fetch, query_elements)
      log.section('Evaluation') do
        v_id = Log.verdict_id(verdict_id, 'name')
        log.verdict_assert_equal?(v_id, label_to_fetch.name, label_fetched.name, 'Label name')
        v_id = Log.verdict_id(verdict_id, 'valid')
        label_fetched.verdict_valid?(log, v_id)
      end
      return label_fetched
    end
  end

end