# Selenium/WebDriver/SearchContext/ElementsPresent/elements_presentQ.rb
# Selenium::WebDriver::SearchContext::ElementsPresent.elements_present?

# 20200412
# 0.1.0

# Examples:
# 1. driver.elements_present?(:xpath, '//li[@class="item"]')

module Selenium
  module WebDriver
    module SearchContext
      module ElementsPresent

        def elements_present?(selector_type, selector)
          bridge.find_elements_by(selector_type, selector)
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
      include SearchContext::ElementsPresent
    end
  end
end
