# -*- coding: UTF-8 -*-

require 'test_helper'

class GuruTest < MiniTest::Spec

  include ::Entities

  it "initializes" do
    Guru.new
  end

  describe "validations" do
    it "works" do
      assert( Guru.new_valid.valid? )

      refute( Guru.new_valid( :name => nil ).valid? )
      refute( Guru.new_valid( :name => " " ).valid? )
      refute( Guru.new_valid( :name => " " ).valid? )
      assert( Guru.create_valid!( :name => "Dave Thomas xxx" ).valid? )      # |\ uniqueness
      refute( Guru.new_valid( :name => "Dave Thomas xxx" ).valid? )          # |/
    end
  end

end
