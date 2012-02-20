# -*- coding: UTF-8 -*-

require 'app_test_helper'

class QueryTest < MiniTest::Spec

  include ::Backends
  include ::Entities

  class Backend < Abstract::Backend; end

  class Gateway < Abstract::Gateway
    def first( query ) end
    def all( query ) end
    def find( query, id ) end
  end

  class Cat < Entity
    attr_accessor :id, :name
  end

  class CatGateway < Gateway; end

  before do
    @query = Query.new( CatGateway.new( Backend.new ) )
  end

  describe ".where" do
    it "returns query with the where option set" do
      conditions = { :name => 'Kitty' }
      @query = @query.where( conditions )
      assert_equal( Query, @query.class )
      assert_equal( conditions, @query.options.where )
    end
  end

  describe ".where_not" do
    it "returns query with the where_not option set" do
      conditions = { :name => 'Kitty' }
      @query = @query.where_not( conditions )
      assert_equal( Query, @query.class )
      assert_equal( conditions, @query.options.where_not )
    end
  end

  describe ".order" do
    it "returns query with the order option set" do
      order = { :name => :asc }
      @query = @query.order( order )
      assert_equal( Query, @query.class )
      assert_equal( order, @query.options.order )
    end
  end

  describe ".first" do
    it "calls gateway.first passing it self" do
      @query.first
    end
  end

  describe ".all" do
    it "calls gateway.all passing it self" do
      @query.all
    end
  end

  describe ".find" do
    it "calls gateway.find passing it self and id" do
      @query.find( 1 )
    end
  end

end
