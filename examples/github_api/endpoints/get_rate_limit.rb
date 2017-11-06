require_relative '../base_classes/base_class_for_endpoint'

require_relative '../data/rate_limit'

class GetRateLimit < BaseClassForEndpoint

  Contract GithubClient, Maybe[Hash] => [RateLimit, Any]
  def self.call_and_return_payload(client, query_elements = {})
    url_elements = [
        'rate_limit',
    ]
    payload = client.get(url_elements, query_elements)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    rate_limit = RateLimit.new(rehash)
    [rate_limit, payload]
  end

  Contract GithubClient, VERDICT_ID, Maybe[Hash] => RateLimit
  def self.verdict_call_and_verify_success(client, verdict_id, query_elements = {})
    log = client.log
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      rate_limit = self.call(client, query_elements)
      log.section('Evaluation') do
        rate_limit.log(log)
        rate_limit.verdict_valid?(log, verdict_id)
      end
      return rate_limit
    end
  end

end
