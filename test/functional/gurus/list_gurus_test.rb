# -*- coding: UTF-8 -*-

require 'test_helper'

class ListGurusTest < MiniTest::Spec

  include ::UseCases
  include ::Entities

  it "returns a list of all Gurus" do
    db.save!( Guru.new( :name => RandomString.generate( 10 ) ) )
    db.save!( Guru.new( :name => RandomString.generate( 10 ) ) )
    response = ListGurus.new.exec
    assert( response.ok? )
    assert_equal( 2, response.gurus.size )
  end

end
