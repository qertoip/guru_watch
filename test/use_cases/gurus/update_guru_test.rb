# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class UpdateGuruTest < MiniTest::Spec

    include ::Entities

    #it 'updates a Guru' do
    #  guru = Guru.create_valid!
    #
    #  atts = { :name => 'Updated name', :description => 'Updated description' }
    #
    #  response = UpdateGuru.new( :id => guru.id, :atts => atts ).exec
    #
    #  assert( response.ok? )
    #  updated_guru = response.guru
    #  assert_equal( atts[:name], updated_guru.name )
    #  assert_equal( atts[:description], updated_guru.description )
    #end

    #it 'returns errors if the passed request is invalid' do
    #  response = CreateGuru.new( :name => '' ).exec
    #  refute( response.ok? )
    #  assert( response.errors )
    #end

  end

end
