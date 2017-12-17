
require 'watir'

require_relative '../../../lib/log/log'

require_relative '../../../lib/base_classes/base_class'

require_relative 'pages/login_page'
require_relative 'pages/repo_page'

class UiClient < BaseClass

  attr_accessor :log, :browser

  # Instantiate a client for the caller's block.
  Contract Log, String, String, String, Proc => nil
  def self.with(log, repo_username, repo_password, repo_name)
    raise 'No block given' unless (block_given?)
    ui_client = self.new(log, im_ok_youre_not_ok = true)
    browser = Watir::Browser.new
    login_page = LoginPage.new(log, browser)
    browser.goto(LoginPage.url)
    login_page.login(repo_username, repo_password)
    repo_url = File.join(
        BaseClassForPage.base_url,
        repo_username,
        repo_name,
    )
    browser.goto(repo_url)
    repo_page = RepoPage.new(log, browser)
    yield ui_client, repo_page
    nil
  end

  def initialize(log, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    self.log = log
  end

end
