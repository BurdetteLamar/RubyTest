require_relative '../base_classes/base_class_for_page'

require_relative 'home_page'

class LoginPage < BaseClassForPage

  LOCATORS = {
      :username => [:text_field, {:id => 'login_field'}],
      :password => [:text_field, {:id => 'password'}],
      :submit => [:button, {:name => 'commit'}],
  }

  Contract Log, Watir::Browser => nil
  def initialize(log, browser)
    relative_url = 'login'
    super(log, browser, relative_url, LOCATORS)
  end

  Contract String, String => HomePage
  def login(username, password)
    visit
    locate(:username).set(username)
    locate(:password).set(password)
    locate(:submit).click
    HomePage.new(log, browser)
  end
end
