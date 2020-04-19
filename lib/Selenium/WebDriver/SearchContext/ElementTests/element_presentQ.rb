# Selenium/WebDriver/SearchContext/ElementPresent/element_presentQ.rb
# Selenium::WebDriver::SearchContext::ElementPresent.element_present?

# 20200412
# 0.1.0

# Examples:
# 1. driver.element_present?(:xpath, '//a[@id="submit"]')

module Selenium
  module WebDriver
    module SearchContext
      module ElementPresent

        def element_present?(selector_type, selector)
          bridge.find_element_by(selector_type, selector)
          true
        rescue Selenium::WebDriver::Error::NoSuchElementError
          false
        end

      end
    end
  end
end

module Selenium
  module WebDriver
    class Driver
      include SearchContext::ElementPresent
    end
  end
end
