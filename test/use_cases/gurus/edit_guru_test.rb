# -*- coding: UTF-8 -*-

require 'app_test_helper'

class EditGuruTest < MiniTest::Spec

  include ::UseCases
  include ::Entities

  it "returns a guru for edition" do
    guru = Guru.create_valid!
    response = EditGuru.new( :id => guru.id ).exec
    assert( response.ok? )
    assert_equal( guru.id, response.guru.id )
  end

end
