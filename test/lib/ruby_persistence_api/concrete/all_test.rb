# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class AllTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'returns list of objects of the specified type' do
      create_four_animals
      cats = db[Cat].all
      assert_equal( 2, cats.size )
      cats.each do |cat|
        assert_equal( Cat, cat.class )
      end
    end

    test 'returns [] if there are no objects' do
      dogs = db[Cat].all
      assert_equal( [], dogs )
    end

  end

end
