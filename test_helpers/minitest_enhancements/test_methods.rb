module MiniTest

  class Unit

    class TestCase

      def self.test_methods # :nodoc:
        methods = public_instance_methods(true).grep(/_TEST$/).map { |m| m.to_s }

        case self.test_order
        when :random then
          max = methods.size
          methods.sort.sort_by { rand max }
        when :alpha, :sorted then
          methods.sort
        else
          raise "Unknown test_order: #{self.test_order.inspect}"
        end
      end

    end

  end

end
