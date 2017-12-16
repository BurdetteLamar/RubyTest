
require 'watir'

require_relative '../../../lib/log/log'

require_relative '../../../lib/base_classes/base_class'

class UiClient < BaseClass

  attr_accessor :log, :browser

  # Instantiate a client for the caller's block.
  Contract Log, String, String, String, Proc => nil
  def self.with(log, repo_username, repo_password, repo_name)
    raise 'No block given' unless (block_given?)
    ui_client = self.new(log, repo_username, repo_password, repo_name, im_ok_youre_not_ok = true)
    yield ui_client
    nil
  end

  def initialize(log, repo_username, repo_password, repo_name, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    self.log = log
    @base_url = 'https://github.com'
    @uri = URI.parse(@base_url)
    browser = Watir::Browser.new
    login_url = File.join(@base_url, 'login')
    browser.goto(login_url)
    browser.text_field(:id, 'login_field').set(repo_username)
    browser.text_field(:id,'password').set(repo_password)
    browser.button(:name, 'commit').click
  end

end
