# -*- coding: UTF-8 -*-

require_relative 'saving_gateway'
require_relative 'retrieval_gateway'

module Backends

  module Memory

    class Gateway < Abstract::Gateway

      include SavingGateway
      include RetrievalGateway

      private

        def root
          backend.root
        end

        def deep_copy( object )
          Marshal.load( Marshal.dump( object ) )
        end

        def entity_to_hash( entity )
          deep_copy( entity.attributes )
        end

        def hashes_to_entities( hashes )
          entity_class = self.class.entity_klass
          deep_copy( hashes ).map { |h| entity_class.new( h ) }
        end

    end

  end

end
