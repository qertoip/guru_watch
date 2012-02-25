# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    module RetrieveGateway

      def all( query = nil )
        query ||= Query.new( self )
        relation = query_to_relation( query )
        models = relation.all
        models_to_entities( models )
      end

      def first( query = nil )
        query ||= Query.new( self )
        relation = query_to_relation( query )
        model = relation.first
        model_to_entity( model ) if model
      end

      def find( id, query = nil )
        query ||= Query.new( self )
        relation = query_to_relation( query )
        begin
          relation.find( id )
        rescue ActiveRecord::RecordNotFound => e
          raise ObjectNotFound.new( "#{entity_class.name}/#{id} not found" )
        end
      end

      private

        def query_to_relation( query )
          relation = model_class.scoped
          relation = add_where( relation, query )
          relation = add_where_not( relation, query )
          relation
        end

        def add_where( relation, query )
          conditions = query.options.where
          return relation unless conditions
          relation.where( conditions )
        end

        def add_where_not( relation, query )
          conditions = query.options.where_not
          return relation unless conditions

          conditions.each do |attr, value|
            sanitized_attr = ActiveRecord::Base.sanitize( attr )
            relation = relation.where( ["#{sanitized_attr} != ?", value] )
          end

          relation
        end

    end

  end

end
