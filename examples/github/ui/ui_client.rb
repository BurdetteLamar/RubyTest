require 'watir'

require_relative '../../../lib/log/log'

require_relative '../../../lib/base_classes/base_class'

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

  Contract Log, String, String, String, Maybe[Bool] => nil
  def initialize(log, username, password, repo_name, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    self.log = log
    self.username = username
    self.password = password
    self.repo_name = repo_name
    nil
  end

  require_relative 'pages/home_page'
  Contract nil => HomePage
  def login
    self.browser = Watir::Browser.new
    require_relative 'pages/login_page'
    page = LoginPage.new(self).visit
    page.login(username, password)
  end

end
