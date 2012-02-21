# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Backends

  module Abstract

    class BackendTest < MiniTest::Spec

      include ::Entities

      class Cat < Entity; end
      class Backend < Backend; end
      class CatGateway < Gateway; end

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
        assert_equal( Query, query.class )
        assert_equal( correct_gateway_class, query.gateway.class )
      end

    end

  end

end
