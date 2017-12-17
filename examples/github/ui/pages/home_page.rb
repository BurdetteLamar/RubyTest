require_relative '../base_classes/base_class_for_page'

class HomePage < BaseClassForPage

  LOCATORS = {}

  Contract Log, Watir::Browser => nil
  def initialize(log, browser)
    super(log, browser, LOCATORS)
  end

end