# Selenium/WebDriver/SearchContext/ElementTests.rb
# Selenium::WebDriver::SearchContext::ElementTests

# 20120701
# 0.0.0

# History: Extracted from ics_review(as it was when written)/ics_slideshow on 20140628.

module Selenium
  module WebDriver
    module SearchContext
      module ElementTests

        def element_present?(selector_type, selector)
          bridge.find_element_by(selector_type, selector)
          true
        rescue Selenium::WebDriver::Error::NoSuchElementError
          false
        end

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
      include SearchContext::ElementTests
    end
  end
end
