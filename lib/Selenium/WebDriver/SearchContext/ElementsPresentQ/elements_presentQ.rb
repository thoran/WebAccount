# Selenium/WebDriver/SearchContext/ElementsPresentQ/elements_presentQ.rb
# Selenium::WebDriver::SearchContext::ElementsPresentQ.elements_present?

# 20200413
# 0.2.0

# Examples:
# 1. driver.elements_present?(:xpath, '//li[@class="item"]')

# Changes:
# 1. Moved elements_present?() into its own module.

module Selenium
  module WebDriver
    module SearchContext
      module ElementsPresentQ

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
      include SearchContext::ElementsPresentQ
    end
  end
end
