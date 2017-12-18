require_relative '../base_classes/base_class_for_page'

class HomePage < BaseClassForPage

  LOCATORS = {}

  Contract Log, Watir::Browser => nil
  def initialize(log, browser)
    relative_url = ''
    super(log, browser, relative_url, LOCATORS)
  end

end