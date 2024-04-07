# WebAccount.rb
# WebAccount

require 'selenium-webdriver'
require 'Thoran/Selenium'

class WebAccount

  attr_accessor :username
  attr_accessor :password
  attr_writer :user_agent_alias

  def initialize(
    username: nil, password: nil,
    login_page_url: nil,
    login_page_username_field_selector: nil, login_page_password_field_selector: nil,
    login_page_submit_button_selector: nil,
    logout_button_selector: nil,
    logged_out_xpath: nil
  )
    @username, @password = username, password
    @login_page_url = login_page_url
    @login_page_username_field_selector, @login_page_password_field_selector = login_page_username_field_selector, login_page_password_field_selector
    @login_page_submit_button_selector = login_page_submit_button_selector
    @logout_button_selector = logout_button_selector
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
      driver.element_present?(@logout_button_selector.keys.first, @logout_button_selector.values.first)
    end
  end
  alias_method :logon, :login

  def logout
    logout_button.click
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
      driver = Selenium::WebDriver.setup(user_agent_alias)
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

  def default_username_field
    {name: "username"}
  end

  def username_field
    if @login_page_username_field_selector
      driver.find_element(@login_page_username_field_selector.keys.first, @login_page_username_field_selector.values.first)
    else
      driver.find_element(default_username_field.keys.first, default_username_field.values.first)
    end
  end

  def enter_password(password = nil)
    password ||= self.password
    password_field.send_keys(password)
  end

  def default_password_field
    {name: "password"}
  end

  def password_field
    if @login_page_password_field_selector
      driver.find_element(@login_page_password_field_selector.keys.first, @login_page_password_field_selector.values.first)
    else
      driver.find_element(default_password_field.keys.first, default_password_field.values.first)
    end
  end

  def default_login_page_submit_button_selector
    {xpath: '//input[@type="submit" and @value="Login"]'}
  end

  def login_page_submit_button
    if @login_page_submit_button_selector
      driver.find_element(@login_page_submit_button_selector.keys.first, @login_page_submit_button_selector.values.first)
    else
      driver.find_element(default_login_page_submit_button_selector.keys.first, default_login_page_submit_button_selector.values.first)
    end
  end

  # logging out

  def default_logout_button_selector
    {xpath: '//input[@type="submit" and @value="Logout"]'}
  end

  def logout_button
    if @logout_page_submit_button_selector
      driver.find_element(@logout_button_selector.keys.first, @logout_button_selector.values.first)
    else
      driver.find_element(default_logout_button_selector.keys.first, default_logout_button_selector.values.first)
    end
  end
end
