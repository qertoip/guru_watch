# -*- coding: UTF-8 -*-

require 'app_test_helper'

class EntityTest < MiniTest::Spec

  include ::Entities

  describe ".initialize" do

    class Dog < Entity
      attr_accessor   :id, :name, :age
    end

    class DogGateway < Backends::Memory::Gateway
      entity_class    :Dog
      attr_persistent :id, :name, :age
    end

    it "initializes without arguments" do
      Dog.new
    end

    it "initializes with nil argument (this convenient in UseCases if frontend didn't pass a request at all)" do
      Dog.new( nil )
    end

    it "initializes with a hash" do
      dog = Dog.new( :name => 'Daisy', :age => 14 )
      assert_equal( dog.age, 14 )
      assert_equal( dog.name, 'Daisy' )
    end

    it "initializes with a hash and options" do
      Dog.new( { :name => 'Daisy', :age => 14 }, { :without_protection => true } )
    end

  end

  #describe ".db" do
  #  it "returns the backend" do
  #    assert( Dog.new.db.is_a?( Backends::AbstractBackend ) )
  #  end
  #end

end
