require_relative '../base_classes/base_class_for_get'

class AlbumsGet < BaseClassForGet

  Contract RestClient => [ArrayOf[Any], Any]
  def self.call_and_return_payload(client)
    super(client)
  end

  # Contract SbmRestClient, Log, String => ArrayOf[SbmGroup]
  # def self.verdict_call_and_verify_success(client, log, verdict_id)
  #   groups = []
  #   log.section(:rescue, :timestamp, :duration, :name => verdict_id) do
  #     log.verdict_nothing_raised?('%s - nothing raised' % verdict_id) do
  #       groups, payload = self.call_and_return_payload(client)
  #       log.section(:name => 'Evaluation') do
  #         keys = self::Keys.new(REQUIRED_KEYS, ALLOWED_KEYS)
  #         payload_keys = ObjectHelper.key_set(payload)
  #         SbmRestClient.verdict_payload_keys_valid_keys?(log, '%s - keys' % verdict_id, keys, payload_keys)
  #         SbmGroup.verdict_data_objects_valid_keys?(log, verdict_id, groups, keys)
  #       end
  #     end
  #   end
  #   groups
  # end

end
