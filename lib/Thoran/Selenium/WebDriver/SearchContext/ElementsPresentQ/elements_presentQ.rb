# Thoran/Selenium/WebDriver/SearchContext/ElementsPresentQ/elements_presentQ.rb
# Thoran::Selenium::WebDriver::SearchContext::ElementsPresentQ.elements_present?

# 20200418
# 0.0.0

# Examples:
# 1. driver.elements_present?(:xpath, '//li[@class="item"]')
# 2. driver.elements_present?(:css, 'li.item')

# Changes:
# 1. + Thoran namespace.

module Thoran
  module Selenium
    module WebDriver
      module SearchContext
        module ElementsPresentQ

          def elements_present?(selector_type, selector)
            bridge.find_elements_by(selector_type, selector)
            true
          rescue ::Selenium::WebDriver::Error::NoSuchElementError
            false
          end

        end
      end
    end
  end
end

module Selenium
  module WebDriver
    class Driver
      include Thoran::Selenium::WebDriver::SearchContext::ElementsPresentQ
    end
  end
end
