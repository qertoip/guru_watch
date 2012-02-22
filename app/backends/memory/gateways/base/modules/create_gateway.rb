# -*- coding: UTF-8 -*-

module Backends

  module Memory

    module CreateGateway

      def create( attributes = {} )
        entity = entity_class.new( attributes )
        save( entity )
        entity
      end

      def create!( attributes = {} )
        entity = entity_class.new( attributes )
        save!( entity )
        entity
      end

    end

  end

end
