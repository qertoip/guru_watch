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

      describe '.[] operator' do

        describe 'when passed a class' do

          it 'deduces a Gateway for the passed class, wraps it into a Query and returns that Query' do
            query = @db[Cat]
            assert_query_is_correct( query )
          end

        end

        describe 'when passed an object' do

          it 'deduces a Gateway for the passed object and returns that Gateway' do
            gateway = @db[Cat.new]
            assert_gateway_is_correct( gateway )
          end

        end

      end

      def assert_query_is_correct( query )
        correct_gateway_class = CatGateway.new(db).class
        assert_equal( Query, query.class )
        assert_equal( correct_gateway_class, query.gateway.class )
      end

      def assert_gateway_is_correct( gateway )
        correct_gateway_class = CatGateway.new( db ).class
        assert_equal( CatGateway, gateway.class )
        assert_equal( correct_gateway_class, gateway.class )
      end

    end

  end

end
