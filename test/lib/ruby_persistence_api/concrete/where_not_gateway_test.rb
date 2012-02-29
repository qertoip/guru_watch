# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class WhereNotTest < RubyPersistenceAPI::TestCase

    include Entities

    test 'selects objects not meeting passed conditions' do
      db[Dog].create!( name: 'Daisy', age: 3 )
      db[Dog].create!( name: 'Monster', age: 6 )
      db[Dog].create!( name: 'Lenny', age: 10 )
      db[Dog].create!( name: 'Nelson', age: 6 )
      db[Dog].create!( name: 'Lenny', age: 12 )
      dogs = db[Dog].where_not( age: 6 ).all
      assert_equal( 3, dogs.size )
      dogs.each do |dog|
        assert( [3, 10, 12].include?( dog.age ) )
      end
    end

  end

end
