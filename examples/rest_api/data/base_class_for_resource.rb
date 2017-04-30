require_relative '../../../lib/base_classes/base_class_for_data'

class BaseClassForResource < BaseClassForData

  Contract ExampleRestClient => self
  def self.get_first(client)
    all = self.get_all(client)
    raise RuntimeError.new('No %s available' % self.name) unless all.size > 0
    all.first
  end

  Contract ExampleRestClient, self => Bool
  def self.exist?(client, album)
    begin
      self.read(client, album)
      return true
    rescue RestClient::NotFound
      return false
    end
  end

  Contract ExampleRestClient, Log, String, self => Bool
  def self.verdict_exist?(client, log, verdict_id, album)
    log.va?(verdict_id, self.exist?(client, album), self.name + ' exists')
  end

  Contract ExampleRestClient, Log, String, self => Bool
  def self.verdict_not_exist?(client, log, verdict_id, album)
    log.vr?(verdict_id, self.exist?(client, album), self.name + ' not exist')
  end

end