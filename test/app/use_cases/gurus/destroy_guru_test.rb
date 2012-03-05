# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class DestroyGuruTest < GuruWatch::TestCase

    include ::Entities

    test 'destroys a Guru' do
      guru = Guru.create_valid!
      response = DestroyGuru.new(id: guru.id).exec
      assert(response.ok?)
    end

  end

end
