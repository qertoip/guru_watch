# -*- coding: UTF-8 -*-

require 'app_test_helper'

class AbstractBackendTest < MiniTest::Spec

  include ::Backends
  include ::Entities

  class Backend < Abstract::Backend; end

  class Cat < Entity
    attr_accessor :id
  end

  class CatGateway < Abstract::Gateway; end

  describe '.object' do

    it 'returns Query with the gateway and entities_name set' do
      db = Backend.new
      query = db.object( Cat )
      assert_equal( Backends::Query, query.class )
      assert_equal( CatGateway.new( db ).class, query.gateway.class )
      assert_equal( :cats, query.options.entities_name )
    end

  end

end
