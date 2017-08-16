require_relative '../../../lib/base_classes/base_class_for_data'
require_relative '../../../lib/helpers/object_helper'

class BaseClassForResource < BaseClassForData

  Contract ExampleRestClient, self => Bool
  # RubyMine cannot find RestClient::NotFound
  # noinspection RubyResolve
  def self.exist?(client, object)
    begin
      self.read(client, object)
      return true
    rescue RestClient::NotFound
      return false
    end
  end

  Contract ExampleRestClient, Log, String, self => Bool
  def self.verdict_exist?(client, log, verdict_id, object)
    log.va?(verdict_id, self.exist?(client, object), self.name + ' exists')
  end

  Contract ExampleRestClient, Log, String, self => Bool
  def self.verdict_not_exist?(client, log, verdict_id, object)
    log.vr?(verdict_id, self.exist?(client, object), self.name + ' not exist')
  end

  # Convenience CRUD (create, read, update, delete), etc.
  # Caller should not have to know how to do the CRUD.

  Contract ExampleRestClient, self => self
  def self.create(client, object)
    token = self.name.downcase
    require_relative '../endpoints/%ss/post_%ss' % [token, token]
    endpoint_class_name = 'Post%ss' % self.name
    klass = ObjectHelper.get_class_for_class_name(endpoint_class_name)
    klass.call(client, object)
  end

  Contract ExampleRestClient, self => self
  def self.read(client, object)
    token = self.name.downcase
    require_relative '../endpoints/%ss/get_%ss_id' % [token, token]
    endpoint_class_name = 'Get%ssId' % self.name
    klass = ObjectHelper.get_class_for_class_name(endpoint_class_name)
    klass.call(client, object)
  end

  Contract ExampleRestClient, self => self
  def self.update(client, object)
    token = self.name.downcase
    require_relative '../endpoints/%ss/put_%ss_id' % [token, token]
    endpoint_class_name = 'Put%ssId' % self.name
    klass = ObjectHelper.get_class_for_class_name(endpoint_class_name)
    klass.call(client, object)
  end

  Contract ExampleRestClient, self => nil
  def self.delete(client, object)
    token = self.name.downcase
    require_relative '../endpoints/%ss/delete_%ss_id' % [token, token]
    endpoint_class_name = 'Delete%ssId' % self.name
    klass = ObjectHelper.get_class_for_class_name(endpoint_class_name)
    klass.call(client, object)
  end

  Contract ExampleRestClient => Maybe[ArrayOf[self]]
  def self.get_all(client)
    token = self.name.downcase
    require_relative '../endpoints/%ss/get_%ss' % [token, token]
    endpoint_class_name = 'Get%ss' % self.name
    klass = ObjectHelper.get_class_for_class_name(endpoint_class_name)
    klass.call(client)
  end

  Contract ExampleRestClient => self
  def self.get_first(client)
    all = self.get_all(client)
    raise RuntimeError.new('No %s available' % self.name) unless all.size > 0
    all.first
  end

end