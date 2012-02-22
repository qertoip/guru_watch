# -*- coding: UTF-8 -*-

module Backends

  module Abstract

    class Gateway

      attr_accessor :backend, :entity

      def initialize( backend, entity = nil )
        self.backend = backend
        self.entity = entity
      end

      class << self
        attr_accessor :entity_klass
      end

      # Declare a class of the entity this gateway is managing, like
      #
      #   entity_class Entities::Dog
      #
      def self.entity_class( entity_klass )
        self.entity_klass = entity_klass
      end

    end

  end

end
