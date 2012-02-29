# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class EditGuruTest < GuruWatch::TestCase

    test 'returns a guru for edition' do
      guru = Entities::Guru.create_valid!
      response = EditGuru.new( id: guru.id ).exec
      assert( response.ok? )
      assert_equal( guru.id, response.guru.id )
    end

  end

end
