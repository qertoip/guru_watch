# -*- coding: UTF-8 -*-

module Backends

  module Concrete

    class CreateGatewayTest < MiniTest::Spec

      describe_each_backend do |backend_module|

        class Rat < Entities::Entity
          attribute :id, :type => Integer
          attribute :name, :type => String
          validates :name, :presence => true
        end

        class RatGateway < backend_module::Gateway
          entity_class Rat
        end

        before do
          @rat_gateway = RatGateway.new( backend_module::Backend.new )
        end

        describe '.create' do

          it 'returns the object if valid' do
            rat = @rat_gateway.create( :name => 'X' )
            assert_equal( Rat, rat.class )
            assert( rat.valid? )
          end

          it 'returns the object if invalid' do
            rat = @rat_gateway.create( :name => '' )
            assert_equal( Rat, rat.class )
            assert( rat.invalid? )
          end

        end

        describe '.create!' do

          it 'returns the object if object was saved' do
            rat = @rat_gateway.create!( :name => 'X' )
            assert_equal( Rat, rat.class )
          end

          it 'throws ObjectIvalid if object was invalid' do
            assert_raises( Backends::ObjectInvalid ) do
              @rat_gateway.create!( :name => '' )
            end
          end

        end

      end

    end

  end

end
