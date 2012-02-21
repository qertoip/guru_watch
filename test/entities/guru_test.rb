# -*- coding: UTF-8 -*-

require 'app_test_helper'

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
      assert( Guru.create_valid!( :name => "Dave Thomas xxx" ).valid? )      # |\ uniqueness
      guru = Guru.new_valid( :name => "Dave Thomas xxx" )
      refute( guru.valid? )          # |/
    end
  end

end
