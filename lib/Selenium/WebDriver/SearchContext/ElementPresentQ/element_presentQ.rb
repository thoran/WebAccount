# Selenium/WebDriver/SearchContext/ElementPresentQ/element_presentQ.rb
# Selenium::WebDriver::SearchContext::ElementPresentQ.element_present?

# 20200413
# 0.2.0

# Examples:
# 1. driver.element_present?(:xpath, '//a[@id="submit"]')

# Changes:
# 1. Moved element_present?() into its own module.

module Selenium
  module WebDriver
    module SearchContext
      module ElementPresentQ

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
      include SearchContext::ElementPresentQ
    end
  end
end
