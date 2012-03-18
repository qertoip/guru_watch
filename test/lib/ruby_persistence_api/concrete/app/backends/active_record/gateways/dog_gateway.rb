# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Backends

    module ActiveRecord

      class DogGateway < RubyPersistenceAPI::ActiveRecord::Gateway

        class Dog < ::ActiveRecord::Base;
        end

        entity_class Entities::Dog
        ar_class Dog

      end

    end

  end

end
