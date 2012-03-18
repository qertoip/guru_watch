# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  module SaveTestHelpers
    def new_valid_dog
      Entities::Dog.new(name: 'X')
    end

    def new_invalid_dog
      Entities::Dog.new(name: '')
    end
  end

  class SaveTest < RubyPersistenceAPI::TestCase

    include Entities
    include SaveTestHelpers

    test 'returns true if valid' do
      result = db[new_valid_dog].save
      assert_equal(true, result)
    end

    test 'returns false if invalid' do
      result = db[new_invalid_dog].save
      assert_equal(false, result)
    end

    test 'creates object if new' do
      assert_difference( 'db[Dog].all.size', +1 ) do
        db[new_valid_dog].save!
      end
    end

    test 'updates object if not new' do
      existing_dog = db[Dog].create!(:name=>'X')
      existing_dog.name = 'Changed name'
      assert_difference( 'db[Dog].all.size', 0 ) do
        db[existing_dog].save!
      end
      updated_dog = db[Dog].first
      assert_equal( 'Changed name', updated_dog.name )
    end

  end

  class SaveWithExclamaitionTest < RubyPersistenceAPI::TestCase

    include Entities
    include SaveTestHelpers

    test 'returns true if object was saved' do
      result = db[new_valid_dog].save!
      assert_equal(true, result)
    end

    test 'throws ObjectIvalid if object was invalid' do
      assert_raises(RubyPersistenceAPI::ObjectInvalid) do
        db[new_invalid_dog].save!
      end
    end

  end

end
