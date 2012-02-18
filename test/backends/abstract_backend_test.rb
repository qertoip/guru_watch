# -*- coding: UTF-8 -*-

require 'app_test_helper'

class AbstractBackendTest < MiniTest::Spec

  include Backends

  class ConcreteBackend < AbstractBackend
  end

  describe ".from" do

    it "returns Query with the backend and from set" do
      db = ConcreteBackend.new
      query = db.from( :users )
      assert_equal( Query, query.class )
      assert_equal( db, query.backend )
      assert_equal( :users, query.options.from )
    end

  end

end
