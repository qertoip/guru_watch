# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class ShowguruTest < GuruWatch::TestCase

    include ::Entities

    test 'returns a guru' do
      Guru.create_valid!
      guru = Guru.create_valid!
      Guru.create_valid!
      response = ShowGuru.new(:id => guru.id).exec
      assert(response.ok?)
      assert_equal(guru, response.guru)
    end

  end

end
