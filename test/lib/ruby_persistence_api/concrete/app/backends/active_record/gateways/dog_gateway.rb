# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Backends

    module ActiveRecord

      class DogGateway < RubyPersistenceAPI::ActiveRecord::Gateway
        entity_class Entities::Dog
        class Dog < ::ActiveRecord::Base;
        end

        def model_class
          Dog
        end
      end

    end

  end

end
