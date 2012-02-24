# -*- coding: UTF-8 -*-

require 'backends_test_helper'

module Backends

  module Concrete

    class UpdateAttributesGatewayTest < MiniTest::Spec

      describe_each_backend do |backend_module|

        class Dog < Entities::Entity
          attribute :id, :type => Integer
          attribute :name, :type => String
          attribute :age, :type => Integer
          validates :name, :presence => true
        end

        class DogGateway < backend_module::Gateway
          entity_class Dog
        end

        before do
          @backend = backend_module::Backend.new
          @dog_gateway = DogGateway.new( @backend )
        end

        describe '.update_attributes' do

          before do
            @dog = db[Dog].create!( :name => 'Daisy' )
          end

          it 'returns true if object was saved' do
            assert( db[@dog].update_attributes( :name => 'Updated name', :age => 1 ) )
          end

          it 'updates attributes in memory' do
            db[@dog].update_attributes( :name => 'Updated name', :age => 1 )
            assert_equal( 'Updated name', @dog.name )
            assert_equal( 1, @dog.age )
          end

          it 'updates attributes in db' do
            db[@dog].update_attributes( :name => 'Updated name', :age => 1 )
            reloaded_dog = db[Dog].find( @dog.id )
            assert_equal( 'Updated name', reloaded_dog.name )
            assert_equal( 1, reloaded_dog.age )
          end

          it 'returns false if object was invalid' do
            refute( db[@dog].update_attributes( :name => '', :age => 1 ) )
          end

        end

        describe '.update_attributes!' do

          it 'returns true if object was saved' do
            dog = Dog.new
            dog_gateway = DogGateway.new( @backend, dog )
            assert( dog_gateway.update_attributes!( :name => 'Updated name' ) )
          end

          it 'throws ObjectIvalid if object was invalid' do
            dog = Dog.new
            dog_gateway = DogGateway.new( @backend, dog )
            #dog.expects( :valid? => false )
            assert_raises( Backends::ObjectInvalid ) do
              dog_gateway.update_attributes!( :name => '' )
            end
          end

        end

      end

    end

  end

end
