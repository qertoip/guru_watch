# -*- coding: UTF-8 -*-

require_relative 'modules/create_gateway'
require_relative 'modules/retrieve_gateway'
require_relative 'modules/save_gateway'
require_relative 'modules/destroy_gateway'
require_relative 'modules/update_attributes_gateway'

module RubyPersistenceAPI

  module ActiveRecord

    class Gateway < Abstract::Gateway

      include CreateGateway
      include RetrieveGateway
      include SaveGateway
      include DestroyGateway
      include UpdateAttributesGateway

      protected

      def ar_class
        self.class.ar_klass
      end

      class << self;
        attr_accessor :ar_klass
      end

      def self.ar_class(ar_klass)
        self.ar_klass = ar_klass
      end

      def entity_to_ar(entity)
        ar_class.new(entity.attributes)
      end

      def ar_to_entity(ar)
        entity_class.new(ar.attributes)
      end

      def ars_to_entities(ars)
        ars.map { |ar| ar_to_entity(ar) }
      end

    end

  end

end
