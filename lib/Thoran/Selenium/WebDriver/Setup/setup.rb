# Thoran/Selenium/WebDriver/Setup/setup.rb
# Thoran::Selenium::WebDriver.setup

# 20200419
# 0.0.1

# Usage:
# 1. Binary is in the path:
#   Selenium::WebDriver.setup('chrome') # String - lowercase
#   Selenium::WebDriver.setup('Chrome') # String - capitalised
#   Selenium::WebDriver.setup(:chrome) # Symbol - lowercase
#   Selenium::WebDriver.setup(:Chrome) # Symbol - capitalised
# 2. Binary is not in the path:
#   Selenium::WebDriver.setup('~/Applications/Firefox.app/Contents/MacOS/firefox-bin')

# Changes:
# 1. + Thoran namespace.

require 'selenium-webdriver'
require 'Thoran/String/ToConst/to_const'

module Thoran
  module Selenium
    module WebDriver
      module Setup

        def setup(path_or_browser)
          if File.exist?(File.expand_path(path_or_browser.to_s))
            path = path_or_browser
            at(path)
            ::Selenium::WebDriver.for(selenium_browser(path))
          else
            browser = path_or_browser.to_sym.downcase
            ::Selenium::WebDriver.for(browser)
          end
        end

        private

        def at(path)
          selenium_binary_constant(path).path = File.expand_path(path)
        end

        def selenium_browser(path)
          case path
          when /chrome/i; :chrome
          when /firefox/i; :firefox
          when /safari/i; :safari
          end
        end

        # This method seem to be necessary only to Firefox, since there are no equivalent constants for Safari or Chrome.
        def selenium_binary_constant(path)
          "Selenium::WebDriver::#{selenium_browser(path).to_s.capitalize}::Binary".to_const
        end

      end
    end
  end
end

module Selenium
  module WebDriver
    extend Thoran::Selenium::WebDriver::Setup
  end
end
