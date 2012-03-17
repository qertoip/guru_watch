# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    module DestroyGateway

      def destroy
        unless entity.new_record?
          self.model_class.destroy(entity.id)
        end

        entity.instance_variable_set('@destroyed', true)
        entity.freeze
      end

    end

  end

end
