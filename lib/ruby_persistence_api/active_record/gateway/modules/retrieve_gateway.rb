# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    module RetrieveGateway

      def all(query = nil)
        query ||= Query.new(self)
        relation = query_to_relation(query)
        ars = relation.all
        ars_to_entities(ars)
      end

      def first(query = nil)
        query ||= Query.new(self)
        relation = query_to_relation(query)
        ar = relation.first
        ar_to_entity(ar) if ar
      end

      def find(id, query = nil)
        query ||= Query.new(self)
        relation = query_to_relation(query)
        begin
          ar_to_entity(relation.find(id))
        rescue ::ActiveRecord::RecordNotFound => e
          raise ObjectNotFound.new("#{entity_class.name}/#{id} not found")
        end
      end

      private

      def query_to_relation(query)
        relation = ar_class.scoped
        relation = add_where(relation, query)
        relation = add_where_not(relation, query)
        relation
      end

      def add_where(relation, query)
        conditions = query.options.where
        return relation unless conditions
        relation.where(conditions)
      end

      def add_where_not(relation, query)
        conditions = query.options.where_not
        return relation unless conditions

        conditions.each do |attr, value|
          sanitized_attr = sanitize(attr)
          relation = relation.where(["#{sanitized_attr} != ?", value])
        end

        relation
      end

      def sanitize(s)
        s.to_s.gsub(/[^0-9a-zA-Z_]/, '')
      end

    end

  end

end
