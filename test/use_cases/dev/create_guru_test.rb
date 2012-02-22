# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class SeedTest < MiniTest::Spec

    it "creates example gurus" do
      response = Seed.new.exec
      assert( response.ok? )

      #assert_equal( atts[:name], guru.name )
      #assert_equal( atts[:homepage], guru.homepage )
      #assert_equal( atts[:description], guru.description )
    end

  end

end
