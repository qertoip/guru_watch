# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    module SaveGateway

      def save_without_validation
        if entity.new_record?
          model = entity_to_model(entity)
        else
          model = model_class.find(entity.id)
          model.update_attributes(entity.attributes)
        end
        model.save(validate: false)

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
          raise ObjectInvalid.new(entity.errors.inspect)
        end
      end

    end

  end

end
