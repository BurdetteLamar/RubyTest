require_relative '../base_classes/base_class_for_endpoint'
# require_relative '../../../../lib/helpers/object_helper'

class BaseClassForPost < BaseClassForEndpoint

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Post', '')
  end

  def self.call_and_return_payload(client, object_to_create)
    url_elements = [
        url_element.downcase,
    ]
    query_elements = []
    parameters = object_to_create.to_hash
    payload = client.post(url_elements, query_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    object_posted = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
    [object_posted, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_post)
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      object_to_post.log(log, data_class_name + ' to post')
      object_posted = self.call(client, object_to_post)
      log.section('Evaluation') do
        object_posted.log(log, 'Posted ' + data_class_name)
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        klass.verdict_equal?(log, data_class_name + ' - posted', object_to_post, object_posted, 'Posted')
        object_fetched = klass.read(client, object_posted)
        klass.verdict_equal?(log, data_class_name + ' - fetched', object_posted, object_fetched, 'Fetched')
      end
      return object_posted
    end
  end

end