# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class ListGurusTest < GuruWatch::TestCase

    include ::Entities

    test 'returns a list of all gurus' do
      Guru.create_valid!
      Guru.create_valid!
      response = ListGurus.new.exec
      assert(response.ok?)
      assert_equal(2, response.gurus.size)
    end

  end

end
