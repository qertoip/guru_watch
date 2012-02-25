# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module RubyPersistenceAPI

  module Abstract

    class BackendTest < ActiveSupport::TestCase

      class Entity; include ActiveAttr::Model end
      class Dog < Entity; end
      class ConcreteBackend < Abstract::Backend; end
      class Gateway < Abstract::Gateway; end
      class DogGateway < Gateway; end

      def setup
        @db = ConcreteBackend.new
      end

      class M_brackets < self  # [] operator

        test 'when passed a class deduces a gateway then wraps it into a query and returns that query' do
          query = @db[Dog]
          assert_query_is_correct( query )
        end
        
        test 'when passed an object deduces a gateway for the passed object and returns that gateway' do
          gateway = @db[Dog.new]
          assert_gateway_is_correct( gateway )
        end

        private

          def assert_query_is_correct( query )
            correct_gateway_class = DogGateway.new( @db ).class
            assert_equal( Query, query.class )
            assert_equal( correct_gateway_class, query.gateway.class )
          end

          def assert_gateway_is_correct( gateway )
            correct_gateway_class = DogGateway.new( @db ).class
            assert_equal( DogGateway, gateway.class )
            assert_equal( correct_gateway_class, gateway.class )
          end

      end

    end

  end

end
