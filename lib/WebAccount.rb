# WebAccount.rb
# WebAccount

# 20170514
# 0.0.0

# Description: An abstract superclass for navigating a web-based user account via Selenium.

require 'selenium-webdriver'
require 'Selenium/WebDriver/SearchContext/ElementTests'

class WebAccount

  attr_accessor :username
  attr_accessor :password
  attr_writer :user_agent_alias

  def initialize(
    username:, password:,
    login_page_url:,
    login_page_username_field_id:, login_page_password_field_id:,
    login_page_submit_button_id:,
    logout_button_id:,
    logged_out_xpath:
  )
    @username, @password = username, password
    @login_page_url = login_page_url
    @login_page_username_field_id, @login_page_password_field_id = login_page_username_field_id, login_page_password_field_id
    @login_page_submit_button_id = login_page_submit_button_id
    @logout_button_id = logout_button_id
    @logged_out_xpath = logged_out_xpath
  end

  def login(username:, password:)
    @logged_in = false
    username = username] || self.username
    password = password] || self.password
    attempts = 0
    loop do
      begin
        get_login_page
        enter_username(username)
        enter_password(password)
        login_page_submit_button.click
        break
      rescue Timeout::Error, Selenium::WebDriver::Error::UnknownError, Selenium::WebDriver::Error::NoSuchElementError => e
        attempts += 1
        if attempts >= 3
          driver.quit
          puts "Giving up after 3 attempts to #{__method__} because #{e}."
          exit
        end
      end
    end
    @logged_in = driver_wait.until do
      driver.element_present?(:id, @logged_out_xpath)
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

  # boolean methods

  def logged_in?
    @logged_in
  end

  def logged_out?
    driver_wait.until do
      driver.element_present?(:xpath, '//button[.="Log in"]')
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
