# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module Backends

  module Concrete

    class RetrieveGatewayTest < MiniTest::Spec

      describe_each_backend do |backend_module|

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

        class DogGateway < backend_module::Gateway;
          entity_class Dog
        end

        class CatGateway < backend_module::Gateway
          entity_class Cat
        end

        before do
          @backend = backend_module::Backend.new
          @cat_gateway = CatGateway.new( @backend )
          @dog_gateway = DogGateway.new( @backend )
        end

        describe '.first' do

          it 'returns the first object' do
            create_four_animals
            dog = @dog_gateway.first
            assert_equal( Dog, dog.class )
          end

          it 'ensures the returned object is a copy of the persistent one' do
            dog = Dog.new( :name => 'Doggy' )
            DogGateway.new( @backend, dog ).save

            @dog_gateway.first.name[3] = '!'

            fresh_dog = @dog_gateway.first
            assert_equal( 'Doggy', fresh_dog.name, 'name should not be changed' )
          end

          it 'returns nil if there are no objects' do
            dog = DogGateway.new( @backend ).first
            assert_nil( dog )
          end

        end

        describe '.all' do

          it 'returns list of objects of the specified type' do
            create_four_animals
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
            DogGateway.new( @backend, Dog.new( :name => 'Daisy', :age => 3 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Monster', :age => 6 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Lenny', :age => 10 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Nelson', :age => 6 ) ).save!
            query = RubyPersistenceAPI::Query.new( @dog_gateway ).where( :age => 6 )
            dogs = @dog_gateway.all( query )
            assert_equal( 2, dogs.size )
            dogs.each do |dog|
              assert_equal( 6, dog.age )
            end
          end

        end

        describe '.where_not' do

          it 'selects objects not meeting passed conditions' do
            DogGateway.new( @backend, Dog.new( :name => 'Daisy', :age => 3 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Monster', :age => 6 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Lenny', :age => 10 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Nelson', :age => 6 ) ).save!
            DogGateway.new( @backend, Dog.new( :name => 'Lenny', :age => 12 ) ).save!
            query = RubyPersistenceAPI::Query.new( @dog_gateway ).where_not( :age => 6 )
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
            create_four_animals

            # Add the dog we'll be searching for
            the_right_dog = Dog.new
            DogGateway.new( @backend, the_right_dog ).save

            # Add more noise data
            create_four_animals

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
            assert_raises( RubyPersistenceAPI::ObjectNotFound ) do
              DogGateway.new( @backend, Dog.new ).save
              @dog_gateway.find( 764575723 )
            end
          end

        end

      end

      def create_four_animals
        2.times do
          CatGateway.new(@backend, Cat.new).save!
          DogGateway.new(@backend, Dog.new).save!
        end
      end

    end

  end

end
