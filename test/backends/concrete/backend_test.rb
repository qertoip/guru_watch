# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Backends

  module Concrete

    class BackendTest < MiniTest::Spec

      class Dog < Entities::Entity
        attribute :id, :type => Integer
        attribute :name, :type => String
        attribute :age, :type => Integer
      end

      [Memory].each do |backend_module|

        class DogGateway < backend_module::Gateway
          entity_class Dog
        end

        before do
          @db = backend_module::Backend.new
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
            dog = Dog.new( :name => dog_name )
            @db[dog].save!
            assert( @db[Dog].where( :name => dog_name ).first )
            block_executed = true
            raise exception_class
          end
        rescue exception_class => e
          assert( block_executed, "Block didn't executed: #{e.message}" )
          assert_nil( @db[Dog].where( :name => dog_name ).first )
        end
      end

    end

  end

end
