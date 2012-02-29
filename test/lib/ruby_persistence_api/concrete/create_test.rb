# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class CreateTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'returns the object if valid' do
      dog = db[Dog].create( name: 'X' )
      assert_equal( Dog, dog.class )
      assert( dog.valid? )
    end

    test 'returns the object if invalid' do
      dog = db[Dog].create( name: '' )
      assert_equal( Dog, dog.class )
      assert( dog.invalid? )
    end

  end

  class CreateWithExclamaitionTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'returns the object if object was saved' do
      dog = db[Dog].create!( name: 'X' )
      assert_equal( Dog, dog.class )
    end

    test 'throws ObjectIvalid if object was invalid' do
      assert_raises( RubyPersistenceAPI::ObjectInvalid ) do
        db[Dog].create!( name: '' )
      end
    end

  end

end
