require_relative '../../../../lib/base_classes/base_class'

require_relative '../../../../lib/log/log'

require_relative '../ui_client'

class BaseClassForPage < BaseClass

  attr_accessor :ui_client, :url, :locators

  Contract UiClient, String, HashOf[Symbol, Array[Symbol, HashOf[Symbol, String]]] => nil
  def initialize(ui_client, relative_url, locators)
    self.ui_client = ui_client
    self.url = File.join('https://github.com', relative_url)
    self.locators = locators
    nil
  end

  Contract nil => self
  def visit
    ui_client.browser.goto(url)
    self
  end

  Contract Symbol => Watir::Element
  def locate(locator_name)
    ui_client.browser.send(*locators[locator_name])
  end

end