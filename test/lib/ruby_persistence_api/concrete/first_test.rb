# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class FirstTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'returns the first object' do
      create_four_animals
      dog = db[Dog].first
      assert_equal(Dog, dog.class)
    end

    test 'ensures the returned object is a copy of the persistent one' do
      dog = Dog.new(name: 'Doggy')
      dog = db[dog].create!(name: 'Doggy')

      dog.name[3] = '!'

      fresh_dog = db[Dog].first
      assert_equal('Doggy', fresh_dog.name, 'name should not be changed')
    end

    test 'returns nil if there are no objects' do
      dog = db[Dog].first
      assert_nil(dog)
    end

  end

end
