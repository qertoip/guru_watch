# -*- coding: UTF-8 -*-

module Backends

  module ActiveRecord

    module SaveGateway

      def save_without_validation
        model = entity_to_model( entity )
        model.save( :validate => false )

        if entity.id.nil?
          entity.id = model.id
        end

        nil
      end

      def save
        if entity.valid?
          save_without_validation
          true
        else
          false
        end
      end

      def save!
        if entity.valid?
          save_without_validation
          true
        else
          raise ObjectInvalid.new( entity.errors.inspect )
        end
      end

    end

  end

end
