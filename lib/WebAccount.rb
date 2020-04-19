# WebAccount.rb
# WebAccount

# 20200417
# 0.2.0

# Description: An abstract superclass for navigating a web-based user account via Selenium.

# Changes:
# 1. + Thoran namespace.

require 'selenium-webdriver'
require 'Thoran/Selenium/WebDriver/Driver/Attempt/attempt'
require 'Thoran/Selenium/WebDriver/Remote/W3C/Bridge/ConvertLocators/convert_locators'
require 'Thoran/Selenium/WebDriver/SearchContext/ElementPresentQ/element_presentQ'

class WebAccount

  attr_accessor :username
  attr_accessor :password
  attr_writer :user_agent_alias

  def initialize(
    username: nil, password: nil,
    login_page_url: nil,
    login_page_username_field_id: nil, login_page_password_field_id: nil,
    login_page_submit_button_id: nil,
    logout_button_id: nil,
    logged_out_xpath: nil
  )
    @username, @password = username, password
    @login_page_url = login_page_url
    @login_page_username_field_id, @login_page_password_field_id = login_page_username_field_id, login_page_password_field_id
    @login_page_submit_button_id = login_page_submit_button_id
    @logout_button_id = logout_button_id
    @logged_out_xpath = logged_out_xpath
  end

  def login(username: nil, password: nil)
    @logged_in = false
    username ||= self.username
    password ||= self.password
    attempts = 0
    driver.attempt do
      get_login_page
      enter_username(username)
      enter_password(password)
      login_page_submit_button.click
    end
    @logged_in = driver_wait.until do
      driver.element_present?(:id, @logout_button_id)
    end
  end
  alias_method :logon, :login

  def logout
    driver.find_element(:id, @logout_button_id).click
    if logged_out?
      @logged_in = false
    end
  end
  alias_method :logoff, :logout

  def shutdown
    logout if logged_in?
    driver.quit
  end

  # predicate methods

  def logged_in?
    @logged_in
  end

  def logged_out?
    driver_wait.until do
      driver.element_present?(:xpath, @logged_out_xpath)
    end
  end

  private

  def user_agent_alias
    @user_agent_alias ||= @user_agent_alias || :chrome
  end

  def driver
    @driver ||= (
      driver = Selenium::WebDriver.for(user_agent_alias)
      driver.manage.timeouts.implicit_wait = 5
      driver
    )
  end

  def driver_wait
    @driver_wait ||= Selenium::WebDriver::Wait.new(timeout: 180)
  end

  # logging in

  def login_page
    driver.get(@login_page_url)
  end
  alias_method :get_login_page, :login_page

  def enter_username(username = nil)
    username ||= self.username
    username_field.send_keys(username)
  end

  def username_field
    driver.find_element(:id, @login_page_username_field_id)
  end

  def enter_password(password = nil)
    password ||= self.password
    password_field.send_keys(password)
  end

  def password_field
    driver.find_element(:id, @login_page_password_field_id)
  end

  def login_page_submit_button
    driver.find_element(:id, @login_page_submit_button_id)
  end

end
