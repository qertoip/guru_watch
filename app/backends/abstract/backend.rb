# -*- coding: UTF-8 -*-

module Backends

  module Abstract

    class Backend

      def object( entity_class )
        ::Backends::Query.new( deduce_gateway_from( entity_class ) )
      end

      alias_method :objects, :object
      alias_method :[], :object

      private

        def deduce_gateway_from( entity_class )
          gateway_class_name = "#{entity_class.name.demodulize}Gateway"

          current_module = self.class.name.deconstantize.constantize       # Backends::Memory
          entity_module = entity_class.name.deconstantize.constantize      # SomeUnitTest

          namespaced_class_name_1 = "#{current_module}::#{gateway_class_name}"          # "Backends::Memory::CatGateway"
          namespaced_class_name_2 = "#{entity_module}::#{gateway_class_name}"           # "SomeUnitTest::CatGateway"

          if current_module.constants.include?( gateway_class_name.to_sym )
            gateway_class = namespaced_class_name_1.constantize
          elsif entity_module.constants.include?( gateway_class_name.to_sym )
            gateway_class = namespaced_class_name_2.constantize
          else
            raise StandardError.new( "Cannot find #{gateway_class_name}. Neither #{namespaced_class_name_1} nor #{namespaced_class_name_2} works." )
          end

          gateway_class.new( self )
        end

    end

  end

end
