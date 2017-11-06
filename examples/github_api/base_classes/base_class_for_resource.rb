require_relative '../../../lib/base_classes/base_class_for_data'
require_relative '../../../lib/helpers/object_helper'

class BaseClassForResource < BaseClassForData

  Contract GithubClient, self => Bool
  # RubyMine cannot find RestClient::NotFound
  # noinspection RubyResolve
  def self.exist?(client, object)
    begin
      self.read(client, object)
      return true
    rescue
      return false
    end
  end

  Contract GithubClient, Log, VERDICT_ID, self => Bool
  def self.verdict_exist?(client, log, verdict_id, object)
    message = self.name + ' exists'
    log.va?(verdict_id, self.exist?(client, object), message: message)
  end

  Contract GithubClient, Log, VERDICT_ID, self => Bool
  def self.verdict_not_exist?(client, log, verdict_id, object)
    message = self.name + ' not exist'
    log.vr?(verdict_id, self.exist?(client, object), message: message)
  end

  Contract GithubClient, self => Bool
  def self.delete_if_exist?(client, object)
    if self.exist?(client, object)
      self.delete(client, object)
      return true
    end
    false
  end

  Contract GithubClient => self
  def self.get_first(client)
    all = self.get_all(client)
    raise RuntimeError.new('No %s available' % self.name) unless all.size > 0
    all.first
  end

end