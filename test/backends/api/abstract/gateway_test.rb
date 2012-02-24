# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module Backends

  module Abstract

    class GatewayTest < MiniTest::Unit::TestCase

      class Backend < Backend; end
      class Gateway < Gateway; end
      class Dog < Entities::Entity; end

      def initializes_with_a_backend_TEST
        backend = Backend.new
        gateway = Gateway.new( backend )
        assert_equal( backend, gateway.backend )
      end

      def initializes_with_a_backend_and_entity_TEST
        backend = Backend.new
        dog = Dog.new
        gateway = Gateway.new( backend, dog )
        assert_equal( backend, gateway.backend )
        assert_equal( dog, gateway.entity )
      end

    end

  end

end
