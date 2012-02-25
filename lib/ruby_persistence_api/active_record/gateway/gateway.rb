# -*- coding: UTF-8 -*-

require_relative 'modules/create_gateway'
require_relative 'modules/retrieve_gateway'
require_relative 'modules/save_gateway'
require_relative 'modules/update_attributes_gateway'

module RubyPersistenceAPI

  module ActiveRecord

    class Gateway < Abstract::Gateway

      include CreateGateway
      include RetrieveGateway
      include SaveGateway
      include UpdateAttributesGateway

      protected

        def entity_class
          self.class.entity_klass
        end

        def entity_to_model( entity )
          model_class.new( entity.attributes )
        end

        def model_to_entity( model )
          entity_class.new( model.attributes )
        end

        def models_to_entities( models )
          models.map{ |model| model_to_entity( model ) }
        end

    end

  end

end
