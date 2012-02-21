# -*- coding: UTF-8 -*-

module Backends

  module Memory

    module RetrievalGateway

      def all( query = nil )
        query ||= Query.new( self )
        entity_class_name = self.class.entity_klass.name
        hashes = root[entity_class_name] || []
        hashes = all_where( query, hashes )
        hashes = all_where_not( query, hashes )
        hashes_to_entities( hashes )
      end

      def first( query = nil )
        query ||= Query.new( self )
        all( query ).first  # could be optimized if necessary
      end

      def find( id, query = nil )
        query ||= Query.new( self )
        query.where( :id => id.to_i ).first  ||  raise( ObjectNotFound.new( "#{self.class.entity_klass.name}/#{id} not found" ) )
      end

      private

        def all_where( query, hashes )
          conditions = query.options.where
          return hashes unless conditions
          conditions.stringify_keys!
          hashes.select { |hash| hash_meets_conditions?( hash, conditions ) }
        end

        def all_where_not( query, hashes )
          conditions = query.options.where_not
          return hashes unless conditions
          conditions.stringify_keys!
          hashes.select { |hash| !hash_meets_conditions?( hash, conditions ) }
        end

        def hash_meets_conditions?( hash, conditions )
          conditions.all? { |attr, value|
            hash[attr] == value
          }
        end

    end

  end

end
