require_relative '../../../../lib/base_classes/base_class'

require_relative '../../../../lib/log/log'

class BaseClassForPage < BaseClass

  attr_accessor :log, :browser, :url, :locators

  Contract Log, Watir::Browser, String, HashOf[Symbol, Array[Symbol, HashOf[Symbol, String]]] => nil
  def initialize(log, browser, relative_url, locators)
    self.log = log
    self.browser = browser
    self.url = File.join('https://github.com', relative_url)
    self.locators = locators
    nil
  end

  def visit
    browser.goto(url)
  end

  Contract Symbol => Watir::Element
  def locate(locator_name)
    browser.send(*locators[locator_name])
  end

end