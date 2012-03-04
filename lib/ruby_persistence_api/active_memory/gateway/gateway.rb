# -*- coding: UTF-8 -*-

require_relative 'modules/create_gateway'
require_relative 'modules/retrieve_gateway'
require_relative 'modules/save_gateway'
require_relative 'modules/update_attributes_gateway'
require_relative 'modules/destroy_gateway'

module RubyPersistenceAPI

  module ActiveMemory

    class Gateway < Abstract::Gateway

      include CreateGateway
      include RetrieveGateway
      include SaveGateway
      include UpdateAttributesGateway
      include DestroyGateway

      protected

      def entity_class
        self.class.entity_klass
      end

      def root
        backend.root
      end

      def deep_copy(object)
        Marshal.load(Marshal.dump(object))
      end

      def entity_to_hash(entity)
        deep_copy(entity.attributes)
      end

      def hashes_to_entities(hashes)
        entity_class = self.class.entity_klass
        deep_copy(hashes).map { |h| entity_class.new(h) }
      end

    end

  end

end
