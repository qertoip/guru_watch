# -*- coding: UTF-8 -*-

require 'app_test_helper'

class AbstractGatewayTest < MiniTest::Spec

  include ::Backends

  class Backend < Abstract::Backend; end
  class Gateway < Abstract::Gateway; end

  it 'initializes with a backend' do
    backend = Backend.new
    gateway = Gateway.new( backend )
    assert_equal( backend, gateway.backend )
  end

end
