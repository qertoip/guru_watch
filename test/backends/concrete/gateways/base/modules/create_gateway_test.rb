# -*- coding: UTF-8 -*-

require 'backends_test_helper'

backend_modules.each do |backend_module|

  $backend_module = backend_module

  backend_module.module_eval do

    class self::CreateGatewayTest < ActiveSupport::TestCase

      $stderr.puts Module.nesting

      class Rat < Entities::Entity
        attribute :id, :type => Integer
        attribute :name, :type => String
        validates :name, :presence => true
      end

      class RatGateway < $backend_module::Gateway
        entity_class Rat
        if $backend_module == ::Backends::ActiveRecord
          class Rat < ::ActiveRecord::Base; end
          def model_class; Rat end
        end
      end

      def setup
        @rat_gateway = RatGateway.new( $backend_module::Backend.new )
      end

      class M_create < self

        test "returns the object if valid (#{$backend_module})"  do
          rat = @rat_gateway.create( :name => 'X' )
          assert_equal( Rat, rat.class )
          assert( rat.valid? )
        end

        test "returns the object if invalid (#{$backend_module})" do
          rat = @rat_gateway.create( :name => '' )
          assert_equal( Rat, rat.class )
          assert( rat.invalid? )
        end

      end

      class M_create_with_exclamaition < self

        test "returns the object if object was saved (#{$backend_module}" do
          rat = @rat_gateway.create!( :name => 'X' )
          assert_equal( Rat, rat.class )
        end

        test "throws ObjectIvalid if object was invalid (#{$backend_module}" do
          assert_raises( Backends::ObjectInvalid ) do
            @rat_gateway.create!( :name => '' )
          end
        end

      end

    end

  end

end
