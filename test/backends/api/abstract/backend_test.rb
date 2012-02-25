# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module Backends

  module Abstract

    class BackendTest < ActiveSupport::TestCase

      include ::Entities

      class Cat < Entity; end
      class Backend < Backend; end
      class CatGateway < Gateway; end

      def setup
        @db = Backend.new
      end

      class Method_brackets < BackendTest  # .[]

        test 'when passed a class deduces a gateway then wraps it into a query and returns that query' do
          query = @db[Cat]
          assert_query_is_correct( query )
        end
        
        test 'when passed an object deduces a gateway for the passed object and returns that gateway' do
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
