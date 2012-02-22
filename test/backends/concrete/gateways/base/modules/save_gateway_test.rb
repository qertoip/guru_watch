# -*- coding: UTF-8 -*-

module Backends

  module Concrete

    class SaveGatewayTest < MiniTest::Spec

      describe_each_backend do |backend_module|

        class Dog < Entities::Entity
          attribute :id, :type => Integer
          attribute :name, :type => String
        end

        class DogGateway < backend_module::Gateway
          entity_class Dog
        end

        before do
          @dog_gateway = DogGateway.new( backend_module::Backend.new )
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

      end

    end

  end

end
