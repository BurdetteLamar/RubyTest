require_relative '../base_classes/base_class_for_page'

class HomePage < BaseClassForPage

  LOCATORS = {}

  Contract UiClient => nil
  def initialize(ui_client)
    relative_url = ''
    super(ui_client, relative_url, LOCATORS)
  end

end
