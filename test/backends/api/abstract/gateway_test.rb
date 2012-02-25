# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module Backends

  module Abstract

    class GatewayTest < ActiveSupport::TestCase

      class Backend < Backend; end
      class Gateway < Gateway; end
      class Dog < Entities::Entity; end

      class Method_initialize < GatewayTest

        test 'initializes with a backend' do
          backend = Backend.new
          gateway = Gateway.new( backend )
          assert_equal( backend, gateway.backend )
        end

        test 'initializes with a backend and entity' do
          backend = Backend.new
          dog = Dog.new
          gateway = Gateway.new( backend, dog )
          assert_equal( backend, gateway.backend )
          assert_equal( dog, gateway.entity )
        end

      end

    end

  end

end
