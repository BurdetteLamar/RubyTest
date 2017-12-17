require_relative '../../../../lib/base_classes/base_class'

require_relative '../../../../lib/log/log'

class BaseClassForPage < BaseClass

  attr_accessor :log, :browser, :locators

  Contract Log, Watir::Browser, HashOf[Symbol, Array[Symbol, HashOf[Symbol, String]]] => nil
  def initialize(log, browser, locators)
    self.log = log
    self.browser = browser
    self.locators = locators
    nil
  end

  Contract nil => String
  def self.base_url
    'https://github.com'
  end

  Contract Symbol => Watir::Element
  def locate(locator_name)
    browser.send(*locators[locator_name])
  end

end