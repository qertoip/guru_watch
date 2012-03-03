# -*- coding: UTF-8 -*-

require_relative '../guru_watch/test_case'

module RubyPersistenceAPI

  class TestCase < GuruWatch::TestCase

    def create_four_animals
      2.times do |i|
        db[Entities::Cat].create!
        db[Entities::Dog].create!( name: "Dog #{i}" )
      end
    end

  end

end
