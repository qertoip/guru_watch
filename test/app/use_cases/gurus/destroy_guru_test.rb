# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class DestroyGuruTest < GuruWatch::TestCase

    include ::Entities

    test 'destroys a Guru' do
      guru = Guru.create_valid!
      response = DestroyGuru.new(id: guru.id).exec
      assert(response.ok?)
      assert_raises(RubyPersistenceAPI::ObjectNotFound) do
        db[Guru].find(guru.id)
      end
    end

  end

end
