# -*- coding: UTF-8 -*-

require 'test_helper'

class QueryTest < MiniTest::Spec

  include Backends

  class ConcreteBackend < AbstractBackend
    def first( query ); end
    def all( query ); end
    def find( query, id ); end
  end

  it "initializes" do
    query = Query.new( ConcreteBackend.new, :users )
    assert_equal( :users, query.options.from )
  end

  describe ".where" do
    it "returns query with the where option set" do
      conditions = { :email => 'numbers_of_the_beast@gmail.com' }
      query = Query.new( ConcreteBackend.new, :users ).where( conditions )
      assert_equal( Query, query.class )
      assert_equal( conditions, query.options.where )
    end
  end

  describe ".where_not" do
    it "returns query with the where_not option set" do
      conditions = { :email => 'numbers_of_the_beast@gmail.com' }
      query = Query.new( ConcreteBackend.new, :users ).where_not( conditions )
      assert_equal( Query, query.class )
      assert_equal( conditions, query.options.where_not )
    end
  end

  describe ".order" do
    it "returns query with the order option set" do
      order = { :activated_at => :asc }
      query = Query.new( ConcreteBackend.new, :users ).order( order )
      assert_equal( Query, query.class )
      assert_equal( order, query.options.order )
    end
  end

  describe ".first" do
    it "calls backend.first passing it self" do
      Query.new( ConcreteBackend.new, :users ).first
    end
  end

  describe ".all" do
    it "calls backend.all passing it self" do
      Query.new( ConcreteBackend.new, :users ).all
    end
  end

  describe ".find" do
    it "calls backend.find passing it self and id" do
      Query.new( ConcreteBackend.new, :users ).find( 1 )
    end
  end

end
