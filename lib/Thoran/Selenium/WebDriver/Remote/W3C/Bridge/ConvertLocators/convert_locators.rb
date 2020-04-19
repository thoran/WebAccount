# Thoran/Selenium/WebDriver/Remote/W3C/BridgeMonkeyPatch/ConvertLocators.convert_locators.rb
# Thoran::Selenium::WebDriver::Remote::W3C::BridgeMonkeyPatch::ConvertLocators.convert_locators

# 20200418
# 0.0.0

# Changes:
# 1. + Thoran namespace.

module Thoran
  module Selenium
    module WebDriver
      module Remote
        module W3C
          module Bridge
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
end

module Selenium
  module WebDriver
    module Remote
      module W3C
        Bridge.prepend(Thoran::Selenium::WebDriver::Remote::W3C::Bridge::ConvertLocators)
      end
    end
  end
end
