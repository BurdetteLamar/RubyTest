require_relative '../../base_classes/base_class_for_endpoint'

require_relative '../../data/label'

class GetLabels < BaseClassForEndpoint

  Contract GithubClient, Maybe[Hash] => [ArrayOf[Label], Any]
  def self.call_and_return_payload(client, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'labels',
    ]
    payload = client.get(url_elements, query_elements)
    labels = []
    payload.each do |label_data|
      rehash = HashHelper.rehash_to_symbol_keys(label_data)
      label = Label.new(rehash)
      labels.push(label)
    end
    [labels, payload]
  end

  Contract GithubClient, String, Maybe[Hash] => ArrayOf[Label]
  def self.verdict_call_and_verify_success(client, verdict_id, query_elements = {})
    log = client.log
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      labels = self.call(client, query_elements)
      label = labels.first
      log.section('Info') do
        log.put_element('data', {:fetched_labels_count => labels.size})
        label.log(log, 'First label fetched')
      end
      log.section('Evaluation') do
        log.section('Returned label valid') do
          v_id = Log.verdict_id(verdict_id, 'valid')
          label.verdict_valid?(log, v_id)
        end
      end
      return labels
    end
  end

end
