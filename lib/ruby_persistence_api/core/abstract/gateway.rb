# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Abstract

    class Gateway

      attr_accessor :backend, :entity

      def initialize(backend, entity = nil)
        self.backend = backend
        self.entity = entity
      end

      protected

      def entity_class
        self.class.entity_klass
      end

      class << self;
        attr_accessor :entity_klass
      end

      def self.entity_class(entity_klass)
        self.entity_klass = entity_klass
      end

    end

  end

end
