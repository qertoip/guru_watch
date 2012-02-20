# -*- coding: UTF-8 -*-

require 'app_test_helper'

class ConcreteBackendsTest < MiniTest::Spec

  class Dog < Entities::Entity
    attr_accessor   :id, :name, :age
  end

  [Backends::Memory].each do |backend_module|

    class DogGateway < backend_module::Gateway
      entity_class    Dog
      attr_persistent :id, :name, :age
    end

    before do
      @db = backend_module::Backend.new
    end

    describe ".save_without_validation" do

      it "deduces gateway and passes the call" do
        dog = Dog.new
        @db.save_without_validation( dog )
        assert( dog.id )
      end

    end

    describe ".save" do

      it "deduces gateway and passes the call" do
        dog = Dog.new
        assert( @db.save( dog ) )
        assert( dog.id )
      end

    end

    describe ".save!" do

      it "deduces gateway and passes the call" do
        dog = Dog.new
        assert( @db.save!( dog ) )
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
    dog_name = 'some unique dog name'
    block_executed = false

    begin
      @db.transaction do
        @db.save!( Dog.new(:name => dog_name) )
        assert( @db.object( Dog ).where( :name => dog_name ).first )
        block_executed = true
        raise exception_class
      end
    rescue exception_class => e
      assert( block_executed, "Block didn't executed: #{e.message}" )
      assert_nil( @db.object( Dog ).where( :name => dog_name ).first )
    end
  end

end
