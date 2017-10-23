require_relative '../../base_classes/base_class_for_endpoint'

require_relative '../../data/label'

class PostLabels < BaseClassForEndpoint

  Contract GithubClient, Label, Maybe[Hash] => [Label, Any]
  def self.call_and_return_payload(client, label_to_create, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'labels',
    ]
    parameters = {
        :name => label_to_create.name,
        :color => label_to_create.color,
    }
    payload = client.post(url_elements, query_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    label_created = Label.new(rehash)
    [label_created, payload]
  end

  Contract GithubClient, Log, String, Label, Maybe[Hash] => Label
  def self.verdict_call_and_verify_success(client, log, verdict_id, label_to_create, query_elements = {})
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      label_created = self.call(client, label_to_create, query_elements)
      log.section('Evaluation') do
        log.section('Returned label correct') do
          v_id = Log.verdict_id(verdict_id, 'name')
          log.verdict_assert_equal?(v_id, label_to_create.name, label_created.name, 'Label name')
          v_id = Log.verdict_id(verdict_id, 'color')
          log.verdict_assert_equal?(v_id, label_to_create.color, label_created.color, 'Label color')
        end
        log.section('Returned label valid') do
          v_id = Log.verdict_id(verdict_id, 'valid')
          label_created.verdict_valid?(log, v_id)
        end
        log.section('Label created') do
          v_id = Log.verdict_id(verdict_id, 'exists')
          Label.verdict_exist?(client, log, v_id, label_created)
        end
      end
      return label_created
    end
  end

end
