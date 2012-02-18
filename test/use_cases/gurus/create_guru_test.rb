# -*- coding: UTF-8 -*-

require 'app_test_helper'

class CreateGuruTest < MiniTest::Spec

  include ::UseCases

  it "creates a new Guru" do
    atts = {
        :name => "Robert C. Martin AKA Uncle Bob",
        :homepage => "http://www.8thlight.com/our-team/robert-martin",
        :description => "An award winning author, renowned speaker, and über software geek since 1970. He is the founder and president of Uncle Bob Consulting and Object Mentor."
    }

    response = CreateGuru.new( :atts => atts ).exec

    assert( response.ok? )
    guru = response.guru
    assert( guru.id )
    assert_equal( atts[:name], guru.name )
    assert_equal( atts[:homepage], guru.homepage )
    assert_equal( atts[:description], guru.description )
  end

  it "returns errors if the passed request is invalid" do
    response = CreateGuru.new( :name => '' ).exec
    refute( response.ok? )
    assert( response.errors )
  end

end
