# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveMemory

    module DestroyGateway

      def destroy
        unless entity.new_record?
          class_name = entity.class.name
          hashes = ( root[class_name] ||= [] )
          hash = hashes.find{ |h| h['id'] == entity.id }
          hashes.delete( hash )
        end

        entity.instance_variable_set( '@destroyed', true )
        entity.freeze
      end

    end

  end

end
