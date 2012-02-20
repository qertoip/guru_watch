# -*- coding: UTF-8 -*-

require 'app_test_helper'

class AbstractBackendTest < MiniTest::Spec

  include ::Backends
  include ::Entities

  class Cat < Entity; end
  class Backend < Abstract::Backend; end
  class CatGateway < Abstract::Gateway; end

  before do
    @db = Backend.new
  end

  describe '.object' do

    it 'deduces a Gateway for the passed Entity, wraps it into a Query and returns that Query' do
      query = @db.object( Cat )
      assert_query_is_correct( query )
    end

  end

  describe '.objects' do

    it 'is an alias for #object method' do
      query = @db.objects( Cat )
      assert_query_is_correct( query )
    end

  end

  describe '.[] operator' do

    it 'is an alias for #object method' do
      query = @db[Cat]
      assert_query_is_correct( query )
    end

  end

  def assert_query_is_correct( query )
    correct_gateway_class = CatGateway.new(db).class
    assert_equal(Backends::Query, query.class)
    assert_equal(correct_gateway_class, query.gateway.class)
  end

end
