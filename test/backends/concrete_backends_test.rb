# -*- coding: UTF-8 -*-

require 'app_test_helper'

class ConcreteBackendsTest < MiniTest::Spec

  class Dog < Entities::Entity
    attr_accessor   :id, :name, :age
    attr_persistent :id, :name, :age

    def initialize( hash = {} )
      self.id = hash[:id]
      self.name = hash[:name]
      self.age = hash[:age]
    end
  end

  class Cat < Entities::Entity
    attr_accessor   :id, :name
    attr_persistent :id, :name
  end

  [Backends::Memory::Backend].each do |backend_class|

    before do
      @db = backend_class.new
    end

    describe ".save_without_validation" do

      it "assigns a unique id to a new object" do
        dog = Dog.new
        @db.save_without_validation( dog )
        assert( dog.id )

        dog2 = Dog.new
        @db.save_without_validation( dog2 )
        assert( dog2.id )
        refute_equal( dog.id, dog2.id )
      end

      it "does not change the id of an existing object" do
        dog = Dog.new
        @db.save_without_validation( dog )
        original_id = dog.id

        @db.save_without_validation( dog )  # again
        assert_equal( original_id, dog.id )
      end

      it "stores the object for the future retrieval" do
        dog = Dog.new
        @db.save_without_validation( dog )
        found_dog = @db.from( :dogs ).find( dog.id )
        assert_equal( dog.id, found_dog.id )
      end

      it "stores *copy* of the object (not just a reference)" do
        mem_dog = Dog.new( :name => 'Vaider' )
        @db.save!( mem_dog )
        mem_dog.name = 'Puppy'

        db_dog = @db.from( :dogs ).first
        assert_equal( 'Vaider', db_dog.name )
      end

    end

    describe ".save" do
      it "returns true if object was saved" do
        dog = Dog.new
        dog.expects( :valid? => true )
        assert( @db.save( dog ) )
      end

      it "returns false if object was invalid" do
        dog = Dog.new
        dog.expects( :valid? => false )
        refute( @db.save( dog ) )
      end
    end

    describe ".save!" do
      it "returns true if object was saved" do
        dog = Dog.new
        dog.expects( :valid? => true )
        assert( @db.save!( dog ) )
      end

      it "throws ObjectIvalid if object was invalid" do
        dog = Dog.new
        dog.expects( :valid? => false )
        assert_raises( Backends::ObjectInvalid ) do
          @db.save!( dog )
        end
      end
    end

    describe ".first" do

      it "returns first object" do
        2.times{ @db.save( Dog.new ); @db.save( Cat.new ) }
        dog = @db.from( :dogs ).first
        assert_equal( Dog, dog.class )
      end

      it "returns nil if there are no objects" do
        dog = @db.from( :dogs ).first
        assert_nil( dog )
      end

    end

    describe ".all" do

      it "returns list of objects of the type specified with from option" do
        2.times{ @db.save( Dog.new ); @db.save( Cat.new ) }
        cats = @db.from( :cats ).all
        assert_equal( 2, cats.size )
        cats.each do |cat|
          assert_equal( Cat, cat.class )
        end
      end

      it "returns [] if there are no objects" do
        dogs = @db.from( :dogs ).all
        assert_equal( [], dogs )
      end

    end

    describe ".where" do

      it "selects objects meeting passed conditions" do
        @db.save( Dog.new( :name => 'Daisy', :age => 3 ) )
        @db.save( Dog.new( :name => 'Monster', :age => 6 ) )
        @db.save( Dog.new( :name => 'Lenny', :age => 10 ) )
        @db.save( Dog.new( :name => 'Nelson', :age => 6) )
        dogs = @db.from( :dogs ).where( :age => 6 ).all
        assert_equal( 2, dogs.size )
        dogs.each do |dog|
          assert_equal( 6, dog.age )
        end
      end

    end

    describe ".where_not" do

      it "selects objects not meeting passed conditions" do
        @db.save( Dog.new( :name => 'Daisy', :age => 3 ) )
        @db.save( Dog.new( :name => 'Monster', :age => 6 ) )
        @db.save( Dog.new( :name => 'Lenny', :age => 10 ) )
        @db.save( Dog.new( :name => 'Nelson', :age => 6) )
        @db.save( Dog.new( :name => 'Lenny', :age => 12 ) )
        dogs = @db.from( :dogs ).where_not( :age => 6 ).all
        assert_equal( 3, dogs.size )
        dogs.each do |dog|
          assert( [3, 10, 12].include?( dog.age ) )
        end
      end

    end

    describe ".find" do

      it "finds the object by id" do
        # Add noise data
        2.times{ @db.save( Dog.new ) }
        2.times{ @db.save( Cat.new ) }

        # Add the dog we'll be searching for
        the_right_dog = Dog.new
        @db.save( the_right_dog )

        # Add more noise data
        2.times{ @db.save( Dog.new ) }
        2.times{ @db.save( Cat.new ) }

        found_dog = @db.from( :dogs ).find( the_right_dog.id )
        assert_equal( Dog, found_dog.class )
        assert_equal( the_right_dog.id, found_dog.id )
      end

      it "raises ObjectNotFound exception" do
        assert_raises( Backends::ObjectNotFound ) do
          @db.save( Dog.new )
          @db.from( :dogs ).find( 764575723 )
        end
      end

    end

    describe ".transaction" do

      it "rollbacks data to the pre-transaction state on StandardError" do
        assert_rollback_on( StandardError )
      end

      it "rollbacks data to the pre-transaction state on Exception" do
        assert_rollback_on( Exception )
      end

      it "rollbacks data to the pre-transaction state on Backends::Rollback" do
        assert_rollback_on( Backends::Rollback )
      end

      it "swallows Backends::Rollback pseudo-exception" do
        @db.transaction do
          raise Backends::Rollback
        end
      end

    end

  end

  def assert_rollback_on( exception_class )
    cat_name = 'some unique cat name'
    block_executed = false

    begin
      @db.transaction do
        @db.save!(Cat.new(:name => cat_name))
        assert(@db.from(:cats).where(:name => cat_name).first)
        block_executed = true
        raise exception_class
      end
    rescue exception_class => e
      assert(block_executed, "Block didn't executed: #{e.message}")
      assert_nil(@db.from(:cats).where(:name => cat_name).first)
    end
  end

end
