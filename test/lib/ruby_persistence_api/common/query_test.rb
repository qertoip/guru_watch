# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class QueryTest < RubyPersistenceAPI::TestCase

    class Entity;
      include ActiveAttr::Model
    end

    class Dog < Entity;
      attr_accessor :id, :name;
    end

    class ConcreteBackend < Abstract::Backend;
    end

    class ConcreteGateway < Abstract::Gateway
      def first(query)
      end

      def all(query)
      end

      def find(query, id)
      end

      def create(attributes = { })
      end

      def create!(attributes = { })
      end
    end

    class DogGateway < ConcreteGateway
    end

    def setup
      @query = Query.new(DogGateway.new(ConcreteBackend.new))
    end

    class M_where < self

      test 'returns query with the where option set' do
        conditions = { name: 'Kitty' }
        @query = @query.where(conditions)
        assert_equal(Query, @query.class)
        assert_equal(conditions, @query.options.where)
      end

    end

    class M_where_not < self

      test 'returns query with the where_not option set' do
        conditions = { name: 'Kitty' }
        @query = @query.where_not(conditions)
        assert_equal(Query, @query.class)
        assert_equal(conditions, @query.options.where_not)
      end

    end

    class M_order < self

      test 'returns query with the order option set' do
        order = { name: :asc }
        @query = @query.order(order)
        assert_equal(Query, @query.class)
        assert_equal(order, @query.options.order)
      end

    end

    class M_first < self

      test 'calls gateway.first passing it self' do
        @query.first
      end

    end

    class M_all < self

      test 'calls gateway.all passing it self' do
        @query.all
      end

    end

    class M_find < self

      test 'calls gateway.find passing it self and id' do
        @query.find(1)
      end

    end

    class M_create < self

      test 'calls gateway.create! by passing it self' do
        @query.create
      end

    end

    class M_create_with_exclamation < self

      test 'calls gateway.create! by passing it self' do
        @query.create!
      end

    end

  end

end
