# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Backends

    module ActiveRecord

      class CatGateway < RubyPersistenceAPI::ActiveRecord::Gateway
        entity_class Entities::Cat
        class Cat < ::ActiveRecord::Base;
        end

        def model_class
          Cat
        end
      end

    end

  end

end
