
require 'watir'

require_relative '../../../lib/log/log'

require_relative '../../../lib/base_classes/base_class'

require_relative 'pages/login_page'
require_relative 'pages/repo_page'

class UiClient < BaseClass

  attr_accessor :log, :browser, :username, :password, :repo_name

  # Instantiate a client for the caller's block.
  Contract Log, String, String, String, Proc => nil
  def self.with(log, username, password, repo_name)
    raise 'No block given' unless (block_given?)
    ui_client = self.new(log, username, password, repo_name, im_ok_youre_not_ok = true)
    yield ui_client
    nil
  end

  def initialize(log, username, password, repo_name, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    self.log = log
    self.username = username
    self.password = password
    self.repo_name = repo_name
  end

  def login
    self.browser = Watir::Browser.new
    login_page = LoginPage.new(log, browser)
    login_page.login(username, password)
  end

end
