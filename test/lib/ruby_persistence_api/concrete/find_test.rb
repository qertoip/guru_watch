# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class FindTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'finds the object by id' do
      # Add noise data
      create_four_animals

      # Add the dog we'll be searching for
      the_right_dog = db[Dog].create!(name: 'The Right Dog')

      # Add more noise data
      create_four_animals

      # id:Integer
      found_dog = db[Dog].find(the_right_dog.id)
      assert_equal(Dog, found_dog.class)
      assert_equal(the_right_dog.id, found_dog.id)
      assert_equal(the_right_dog.name, found_dog.name)

      # id:String
      found_dog = db[Dog].find(the_right_dog.id.to_s)
      assert_equal(Dog, found_dog.class)
      assert_equal(the_right_dog.id, found_dog.id)
      assert_equal(the_right_dog.name, found_dog.name)
    end

    test 'raises ObjectNotFound exception' do
      assert_raises(RubyPersistenceAPI::ObjectNotFound) do
        db[Dog].create!(name: 'Some dog')
        db[Dog].find(764575723)
      end
    end

  end

end
