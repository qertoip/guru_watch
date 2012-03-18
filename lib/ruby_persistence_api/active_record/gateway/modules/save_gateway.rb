# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    module SaveGateway

      def save_without_validation
        if entity.new_record?
          ar = entity_to_ar(entity)
        else
          ar = ar_class.find(entity.id)
          ar.update_attributes(entity.attributes)
        end
        ar.save(validate: false)

        if entity.id.nil?
          entity.id = ar.id
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
          raise ObjectInvalid.new(entity.errors.inspect)
        end
      end

    end

  end

end
