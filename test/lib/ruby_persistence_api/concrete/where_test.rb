# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class WhereTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'selects objects meeting passed conditions' do
      db[Dog].create!( :name => 'Daisy', :age => 3 )
      db[Dog].create!( :name => 'Monster', :age => 6 )
      db[Dog].create!( :name => 'Lenny', :age => 10 )
      db[Dog].create!( :name => 'Nelson', :age => 6 )
      dogs = db[Dog].where( :age => 6 ).all
      assert_equal( 2, dogs.size )
      dogs.each do |dog|
        assert_equal( 6, dog.age )
      end
    end

  end

end
