# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Backends

  module Abstract

    class GatewayTest < MiniTest::Spec

      class Backend < Backend; end
      class Gateway < Gateway; end
      class Dog < Entities::Entity; end

      it 'initializes with a backend' do
        backend = Backend.new
        gateway = Gateway.new( backend )
        assert_equal( backend, gateway.backend )
      end

      it 'initializes with a backend and entity' do
        backend = Backend.new
        dog = Dog.new
        gateway = Gateway.new( backend, dog )
        assert_equal( backend, gateway.backend )
        assert_equal( dog, gateway.entity )
      end

    end

  end

end
