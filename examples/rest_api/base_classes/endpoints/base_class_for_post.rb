require_relative '../base_class_for_endpoint'

class BaseClassForPost < BaseClassForEndpoint

  def self.call_and_return_payload(client, object_to_create)
    url_elements = [
        url_element.downcase,
    ]
    parameters = object_to_create.to_hash
    parameters.delete(:id)
    payload = client.post(url_elements, parameters)
    rehash = HashHelper.rehash_to_symbol_keys(payload)
    object_posted = ObjectHelper.instantiate_class_for_class_name(data_class_name, rehash)
    [object_posted, payload]
  end

  def self.verdict_call_and_verify_success(client, log, verdict_id, object_to_post)
    log.section(verdict_id.to_s, :rescue, :timestamp, :duration) do
      object_posted = nil
      log.section('Post') do
        object_to_post.log(log)
        object_posted = self.call(client, object_to_post)
      end
      log.section('Evaluation') do
        klass = ObjectHelper.get_class_for_class_name(data_class_name)
        v_id = [verdict_id, data_class_name.to_sym, :posted]
        klass.verdict_equal?(log, v_id, object_to_post, object_posted)
        # The JSONPlaceholder does not actually modify itself,
        # and so the following verdict would fail.
        # object_fetched = klass.read(client, object_posted)
        # v_id = [verdict_id, data_class_name.to_sym, :fetched]
        # klass.verdict_equal?(log, v_id, object_posted, object_fetched)
      end
      return object_posted
    end
  end

  private

  def self.data_class_name
    self.url_element.sub(/s$/, '')
  end

  def self.url_element
    self.to_s.sub('Post', '')
  end

end