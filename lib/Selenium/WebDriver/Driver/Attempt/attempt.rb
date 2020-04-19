# Selenium/WebDriver/Attempt/attempt.rb
# Selenium::WebDriver::Attempt.attempt

# 20200412
# 0.1.0

# Examples:
# 1.
# driver.attempt do |driver|
#   driver.get('https://example.com/users/sign_in')
#   enter_username
#   enter_password
#   sign_in
# end

module Selenium
  module WebDriver
    module Attempt

      def attempt(max_attempts = 3, &block)
        attempts = 0
        loop do
          begin
            yield
            break
          rescue Timeout::Error, Selenium::WebDriver::Error::UnknownError, Selenium::WebDriver::Error::NoSuchElementError => e
            attempts += 1
            if attempts >= max_attempts
              @driver.quit
              puts "Giving up after #{max_attempts} attempts to #{__method__} because #{e}."
              exit
            end
          end
        end
      end

    end
  end
end

module Selenium
  module WebDriver
    class Driver
      include Attempt
    end
  end
end
