# Selenium::WebDriver::Remote::W3C::BridgeMonkeyPatch::ConvertLocators.convert_locators
# Selenium/WebDriver/Remote/W3C/BridgeMonkeyPatch/ConvertLocators.convert_locators

# 20200417
# 0.1.0

module Selenium
  module WebDriver
    module Remote
      module W3C
        class Bridge
          module ConvertLocators

            def convert_locators(how, what)
              case how.to_s
              when 'class name'
                how = 'css selector'
                what = ".#{escape_css(what)}"
              when 'id'
                how = 'css selector'
                what = "##{escape_css(what)}"
              when 'name'
                how = 'css selector'
                what = "*[name='#{escape_css(what)}']"
              when 'tag name'
                how = 'css selector'
              end
              [how, what]
            end

          end
        end
      end
    end
  end
end

module Selenium
  module WebDriver
    module Remote
      module W3C
        Bridge.prepend(Bridge::ConvertLocators)
      end
    end
  end
end
