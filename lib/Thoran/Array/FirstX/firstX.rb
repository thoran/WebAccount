# Thoran/Array/FirstX/firstX.rb
# Thoran::Array::FirstX#first!

# 20141223
# 0.1.0

# Description: Sometimes it makes more sense to treat arrays this way.

module Thoran
  module Array
    module FirstX

      def first!
        shift
      end

    end
  end
end

Array.send(:include, Thoran::Array::FirstX)
