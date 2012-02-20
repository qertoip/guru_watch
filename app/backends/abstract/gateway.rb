# -*- coding: UTF-8 -*-

module Backends

  module Abstract

    class Gateway

      attr_accessor :backend

      class << self
        attr_accessor :entity_klass
      end

      def initialize( backend )
        self.backend = backend
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
