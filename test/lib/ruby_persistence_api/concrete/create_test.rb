    # -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class CreateTest < RubyPersistenceAPI::TestCase

    #class Rat < Entities::Entity
    #  attribute :id, :type => Integer
    #  attribute :name, :type => String
    #  validates :name, :presence => true
    #end
    #
    #class RatGateway < $backend_module::Gateway
    #  entity_class Rat
    #  if $backend_module == ::RubyPersistenceAPI::ActiveRecord
    #    class Rat < ::ActiveRecord::Base; end
    #    def model_class; Rat end
    #  end
    #end

    #def setup
    #  @rat_gateway = RatGateway.new( $backend_module::Backend.new )
    #end

    include Entities

    test 'returns the object if valid' do
      dog = db[Dog].create( :name => 'X' )
      assert_equal( Dog, dog.class )
      assert( dog.valid? )
    end

    test 'returns the object if invalid' do
      dog = db[Dog].create( :name => '' )
      assert_equal( Dog, dog.class )
      # TODO: add validations
      assert( dog.invalid? )
    end

  end

  class CreateWithExclamaitionTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'returns the object if object was saved' do
      dog = db[Dog].create!( :name => 'X' )
      assert_equal( Dog, dog.class )
    end

    test 'throws ObjectIvalid if object was invalid' do
      # TODO: add validations
      assert_raises( RubyPersistenceAPI::ObjectInvalid ) do
        db[Dog].create!( :name => '' )
      end
    end

  end

end
