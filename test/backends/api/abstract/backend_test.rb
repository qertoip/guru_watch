# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module Backends

  module Abstract

    class BackendTest < MiniTest::Unit::TestCase

      include ::Entities

      class Cat < Entity; end
      class Backend < Backend; end
      class CatGateway < Gateway; end

      def setup
        @db = Backend.new
      end

          # []
      class BracketsOperatorMethod < BackendTest

        def when_passed_a_class_deduces_a_gateway_then_wraps_it_into_a_query_and_returns_that_query_TEST
          query = @db[Cat]
          assert_query_is_correct( query )
        end
        
        def when_passed_an_object_deduces_a_gateway_for_the_passed_object_and_returns_that_gateway_TEST
          gateway = @db[Cat.new]
          assert_gateway_is_correct( gateway )
        end

        private

          def assert_query_is_correct( query )
            correct_gateway_class = CatGateway.new( @db ).class
            assert_equal( Query, query.class )
            assert_equal( correct_gateway_class, query.gateway.class )
          end

          def assert_gateway_is_correct( gateway )
            correct_gateway_class = CatGateway.new( @db ).class
            assert_equal( CatGateway, gateway.class )
            assert_equal( correct_gateway_class, gateway.class )
          end

      end

    end

  end

end
