# -*- coding: UTF-8 -*-

module Backends

  module Concrete

    class UpdateAttributesGatewayTest < MiniTest::Spec

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

        #describe '.update_attributes' do
        #
        #  before do
        #    @dog = db[Dog].create!( :name => 'Daisy' )
        #  end
        #
        #  it 'returns true if object was saved' do
        #    assert( db.update_attributes( @dog, :name => 'Updated name', :age => 1 ) )
        #  end
        #
        #  it 'updates attributes in memory' do
        #    db.update_attributes( @dog, :name => 'Updated name', :age => 1 )
        #    assert_equal( 'Updated name', @dog.name )
        #    assert_equal( 1, @dog.age )
        #  end
        #
        #  it 'updates attributes in db' do
        #    db.update_attributes( @dog, :name => 'Updated name', :age => 1 )
        #    reloaded_dog = db[Dog].find( @dog.id )
        #    assert_equal( 'Updated name', reloaded_dog.name )
        #    assert_equal( 1, reloaded_dog.age )
        #  end
        #
        #  it 'returns false if object was invalid' do
        #    refute( db.update_attributes( @dog, :name => '', :age => 1 ) )
        #  end
        #
        #end

        #describe '.save!' do
        #
        #  it 'returns true if object was saved' do
        #    dog = Dog.new
        #    dog.expects( :valid? => true )
        #    assert( @dog_gateway.save!( dog ) )
        #  end
        #
        #  it 'throws ObjectIvalid if object was invalid' do
        #    dog = Dog.new
        #    dog.expects( :valid? => false )
        #    assert_raises( Backends::ObjectInvalid ) do
        #      @dog_gateway.save!( dog )
        #    end
        #  end
        #
        #end

      end

    end

  end

end
