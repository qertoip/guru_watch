# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  module Abstract

    class GatewayTest < RubyPersistenceAPI::TestCase

      class Entity; include ActiveAttr::Model end
      class Dog < Entity; end
      class ConcreteBackend < Abstract::Backend; end
      class Gateway < Abstract::Gateway; end

      class M_initialize < self

        test 'initializes with a backend' do
          backend = ConcreteBackend.new
          gateway = Gateway.new( backend )
          assert_equal( backend, gateway.backend )
        end

        test 'initializes with a backend and entity' do
          backend = ConcreteBackend.new
          dog = Dog.new
          gateway = Gateway.new( backend, dog )
          assert_equal( backend, gateway.backend )
          assert_equal( dog, gateway.entity )
        end

      end

    end

  end

end
