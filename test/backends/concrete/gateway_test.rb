# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Backends

  module Concrete

    class GatewayTest < MiniTest::Spec

      class Dog < Entities::Entity
        attribute :id, :type => Integer
        attribute :name, :type => String
        attribute :age, :type => Integer
        attribute :price, :type => BigDecimal
        attribute :bought_at, :type => DateTime
        attribute :active, :type => Boolean
      end

      class Cat < Entities::Entity
        attribute :id, :type => Integer
        attribute :name, :type => String
      end

      [Memory].each do |backend_module|

        class DogGateway < backend_module::Gateway
          entity_class    Dog
        end

        class CatGateway < backend_module::Gateway
          entity_class    Cat
        end

        before do
          backend = backend_module::Backend.new
          @dog_gateway = DogGateway.new( backend )
          @cat_gateway = CatGateway.new( backend )
        end

        describe '.save_without_validation' do

          it 'assigns a unique id to a new object' do
            dog = Dog.new
            @dog_gateway.save_without_validation( dog )
            assert( dog.id )

            dog2 = Dog.new
            @dog_gateway.save_without_validation( dog2 )
            assert( dog2.id )
            refute_equal( dog.id, dog2.id )
          end

          it 'does not change the id of an existing object' do
            dog = Dog.new
            @dog_gateway.save_without_validation( dog )
            original_id = dog.id

            @dog_gateway.save_without_validation( dog )  # again
            assert_equal( original_id, dog.id )
          end

          it 'stores the object for the future retrieval' do
            dog = Dog.new
            @dog_gateway.save_without_validation( dog )
            found_dog = @dog_gateway.find( dog.id )
            assert_equal( dog.id, found_dog.id )
          end

          it 'stores *copy* of the object (not just a reference)' do
            mem_dog = Dog.new( :name => 'Vader' )
            @dog_gateway.save!( mem_dog )
            mem_dog.name = 'Puppy'

            db_dog = @dog_gateway.first
            assert_equal( 'Vader', db_dog.name )
          end

        end

        describe '.save' do

          it 'returns true if object was saved' do
            dog = Dog.new
            dog.expects( :valid? => true )
            assert( @dog_gateway.save( dog ) )
          end

          it 'returns false if object was invalid' do
            dog = Dog.new
            dog.expects( :valid? => false )
            refute( @dog_gateway.save( dog ) )
          end

        end

        describe '.save!' do

          it 'returns true if object was saved' do
            dog = Dog.new
            dog.expects( :valid? => true )
            assert( @dog_gateway.save!( dog ) )
          end

          it 'throws ObjectIvalid if object was invalid' do
            dog = Dog.new
            dog.expects( :valid? => false )
            assert_raises( Backends::ObjectInvalid ) do
              @dog_gateway.save!( dog )
            end
          end

        end

        describe '.first' do

          it 'returns the first object' do
            2.times{ @cat_gateway.save( Cat.new ); @dog_gateway.save( Dog.new ) }
            dog = @dog_gateway.first
            assert_equal( Dog, dog.class )
          end

          it 'ensures the returned object is a copy of the persistent one' do
            @dog_gateway.save( Dog.new( :name => 'Doggy' ) )
            @dog_gateway.first.name[3] = '!'

            fresh_dog = @dog_gateway.first
            assert_equal( 'Doggy', fresh_dog.name, 'name should not be changed' )
          end

          it 'returns nil if there are no objects' do
            dog = @dog_gateway.first
            assert_nil( dog )
          end

        end

        describe '.all' do

          it 'returns list of objects of the specified type' do
            2.times{ @dog_gateway.save( Dog.new ); @cat_gateway.save( Cat.new ) }
            cats = @cat_gateway.all
            assert_equal( 2, cats.size )
            cats.each do |cat|
              assert_equal( Cat, cat.class )
            end
          end

          it 'returns [] if there are no objects' do
            dogs = @dog_gateway.all
            assert_equal( [], dogs )
          end

        end

        describe '.where' do

          it 'selects objects meeting passed conditions' do
            @dog_gateway.save( Dog.new( :name => 'Daisy', :age => 3 ) )
            @dog_gateway.save( Dog.new( :name => 'Monster', :age => 6 ) )
            @dog_gateway.save( Dog.new( :name => 'Lenny', :age => 10 ) )
            @dog_gateway.save( Dog.new( :name => 'Nelson', :age => 6) )
            query = Backends::Query.new( @dog_gateway ).where( :age => 6 )
            dogs = @dog_gateway.all( query )
            assert_equal( 2, dogs.size )
            dogs.each do |dog|
              assert_equal( 6, dog.age )
            end
          end

        end

        describe '.where_not' do

          it 'selects objects not meeting passed conditions' do
            @dog_gateway.save( Dog.new( :name => 'Daisy', :age => 3 ) )
            @dog_gateway.save( Dog.new( :name => 'Monster', :age => 6 ) )
            @dog_gateway.save( Dog.new( :name => 'Lenny', :age => 10 ) )
            @dog_gateway.save( Dog.new( :name => 'Nelson', :age => 6) )
            @dog_gateway.save( Dog.new( :name => 'Lenny', :age => 12 ) )
            query = Backends::Query.new( @dog_gateway ).where_not( :age => 6 )
            dogs = @dog_gateway.all( query )
            assert_equal( 3, dogs.size )
            dogs.each do |dog|
              assert( [3, 10, 12].include?( dog.age ) )
            end
          end

        end

        describe '.find' do

          it 'finds the object by id' do
            # Add noise data
            2.times{ @dog_gateway.save( Dog.new ) }
            2.times{ @cat_gateway.save( Cat.new ) }

            # Add the dog we'll be searching for
            the_right_dog = Dog.new
            @dog_gateway.save( the_right_dog )

            # Add more noise data
            2.times{ @dog_gateway.save( Dog.new ) }
            2.times{ @cat_gateway.save( Cat.new ) }

            # id:Integer
            found_dog = @dog_gateway.find( the_right_dog.id )
            assert_equal( Dog, found_dog.class )
            assert_equal( the_right_dog.id, found_dog.id )

            # id:String
            found_dog = @dog_gateway.find( the_right_dog.id.to_s )
            assert_equal( Dog, found_dog.class )
            assert_equal( the_right_dog.id, found_dog.id )
          end

          it 'raises ObjectNotFound exception' do
            assert_raises( Backends::ObjectNotFound ) do
              @dog_gateway.save( Dog.new )
              @dog_gateway.find( 764575723 )
            end
          end

        end

      end

    end

  end

end
