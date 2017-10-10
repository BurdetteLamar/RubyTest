require_relative '../base_classes/base_class_for_endpoint'

require_relative '../data/issue_label'

class GetIssuesNumberLabels < BaseClassForEndpoint

  Contract GithubClient, Fixnum, Maybe[Hash] => [ArrayOf[IssueLabel], Array]
  def self.call_and_return_payload(client, issue_number, query_elements = {})
    url_elements = [
        client.repo_url_elements,
        'issues',
        issue_number.to_s,
        'labels'
    ]
    payload = client.get(url_elements, query_elements)
    issue_labels = []
    payload.each do |hash|
      rehash = HashHelper.rehash_to_symbol_keys(hash)
      obj = ObjectHelper.instantiate_class_for_class_name(IssueLabel.name, rehash)
      issue_labels.push(obj)
    end
    [issue_labels, payload]
  end

  Contract GithubClient, Log, String, Maybe[Hash] => ArrayOf[IssueLabel]
  def self.verdict_call_and_verify_success(client, log, verdict_id, issue_number, query_elements = {})
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      issue_labels = self.call(client, issue_number, query_elements)
      log.section('Evaluation') do
        issue_label = issue_labels.first
        log.put_element('data', {:fetched_issue_labels_count => issue_labels.size})
        log.section('First issue label fetched') do
          issue_label.log(log)
        end
        issue_label.verdict_valid?(log, verdict_id)
      end
      return issue_labels
    end
  end

end
