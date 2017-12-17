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
    super(log, browser, LOCATORS)
  end

  Contract nil => String
  def self.url
    File.join(self.base_url, 'login')
  end

  Contract String, String => HomePage
  def login(username, password)
    locate(:username).set(username)
    locate(:password).set(password)
    locate(:submit).click
    HomePage.new(log, browser)
  end
end
