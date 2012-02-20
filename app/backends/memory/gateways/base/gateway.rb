# -*- coding: UTF-8 -*-

require_relative 'saving_gateway'
require_relative 'retrieval_gateway'

module Backends

  module Memory

    class Gateway < Abstract::Gateway

      include SavingGateway
      include RetrievalGateway

      class << self
        attr_accessor :persistent_attribute_names
      end

      # Declare a set of persistent attributes like
      #
      #   attr_persistent :id, :email, :password_hash
      #
      def self.attr_persistent( *attribute_names )
        self.persistent_attribute_names ||= []
        self.persistent_attribute_names += attribute_names
      end

      # Returns a hash of attribute -> value pairs like
      #
      #   # => { :id => 2, :email => 'john@gmail.com', :password_hash => 'some long hash' }
      #
      def persistent_attributes( entity )
        if self.class.persistent_attribute_names.nil? || self.class.persistent_attribute_names.empty?
          raise MissingPersistentAttributes.new( "Add attr_persistent(:list, :of, :attributes) declaration to #{self.class.name}" )
        end

        hash = {}
        self.class.persistent_attribute_names.each do |attr|
          hash[attr] = entity.send( attr )
        end

        hash
      end

      private

        def root
          backend.root
        end

        def deep_copy( object )
          backend.deep_copy( object )
        end

        def entity_to_hash( entity )
          deep_copy( persistent_attributes( entity ) )
        end

        def hashes_to_entities( hashes )
          entity_class = self.class.entity_klass
          deep_copy( hashes ).map { |h| entity_class.new( h ) }
        end

    end

  end

end
