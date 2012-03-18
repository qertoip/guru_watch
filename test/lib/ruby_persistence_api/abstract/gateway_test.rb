# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  module Abstract

    class GatewayTest < RubyPersistenceAPI::TestCase

      class Entity
        include ActiveAttr::Model
      end

      class Dog < Entity
      end

      class ConcreteBackend < Abstract::Backend
      end

      class Gateway < Abstract::Gateway
      end

      class M_initialize < self

        test 'initializes with a backend' do
          backend = ConcreteBackend.new
          gateway = Gateway.new(backend)
          assert_equal(backend, gateway.backend)
        end

        test 'initializes with a backend and entity' do
          backend = ConcreteBackend.new
          dog = Dog.new
          gateway = Gateway.new(backend, dog)
          assert_equal(backend, gateway.backend)
          assert_equal(dog, gateway.entity)
        end

      end

      class M_entity_class < self

        class SomeGateway < Gateway
        end

        test 'sets class of the entity which becomes accessible on gateway object' do
          SomeGateway.entity_class(Dog)
          some_gateway = SomeGateway.new( Backend.new )
          assert_equal(Dog, some_gateway.send(:entity_class))
        end

      end

    end

  end

end
