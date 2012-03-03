# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Entities

  class EntityTest < ActiveSupport::TestCase

    class M_initialize < self

      class Dog < Entities::Entity
        attribute :id, type: Integer
        attribute :name, type: String
        attribute :age, type: Integer
        attribute :price, type: BigDecimal
        attribute :bought_at, type: DateTime
        attribute :active, type: Boolean
      end

      test 'initializes without arguments' do
        Dog.new
      end

      test 'initializes with nil argument (this convenient in UseCases if frontend didn\'t pass a request at all)' do
        Dog.new( nil )
      end

      test 'initializes with a hash' do
        dog = Dog.new( name: 'Daisy', age: 14 )
        assert_equal( dog.age, 14 )
        assert_equal( dog.name, 'Daisy' )
      end

      test 'initializes with a hash and options' do
        Dog.new( { name: 'Daisy', age: 14 }, { without_protection: true } )
      end

      test 'auto-converts strings to strongly typed values' do
        dog = Dog.new(
            name: 'Buldog',
            age: '18',
            price: '197.98',
            bought_at: '2000-03-04 17:35',
            active: '1' )
        assert_equal( 'Buldog', dog.name )
        assert_equal( 18, dog.age )
        assert_equal( BigDecimal.new( '197.98' ), dog.price )
        assert_equal( DateTime.parse( '2000-03-04 17:35' ), dog.bought_at )
        assert_equal( true, dog.active? )  # must be a TrueClass, i.e. not '1'
      end

    end

  end

end
