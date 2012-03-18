# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Backends

    module ActiveRecord

      class CatGateway < RubyPersistenceAPI::ActiveRecord::Gateway

        class Cat < ::ActiveRecord::Base
        end

        entity_class Entities::Cat
        ar_class Cat

      end

    end

  end

end
