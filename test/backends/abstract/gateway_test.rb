# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Backends

  module Abstract

    class GatewayTest < MiniTest::Spec

      class Backend < Backend; end
      class Gateway < Gateway; end

      it 'initializes with a backend' do
        backend = Backend.new
        gateway = Gateway.new( backend )
        assert_equal( backend, gateway.backend )
      end

    end

  end

end
