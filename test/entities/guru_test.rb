# -*- coding: UTF-8 -*-

require 'app_test_helper'

module Entities

  class GuruTest < GuruWatch::TestCase

    class Validations < self
      test 'work' do
        assert( Guru.new_valid.valid? )

        refute( Guru.new_valid( :name => nil ).valid? )
        refute( Guru.new_valid( :name => ' ' ).valid? )
        assert( Guru.create_valid!( :name => 'Dave Thomas xxx' ).valid? )      # |\ uniqueness
        refute( Guru.new_valid( :name => 'Dave Thomas xxx' ).valid? )          # |/
      end
    end

  end

end
