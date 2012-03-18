# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class SeedDatabaseTest < GuruWatch::TestCase

    include ::Entities

    test 'destroys any existing data' do
      SeedDatabase.new.exec
      assert_difference( 'db[Guru].all.size', 0 ) do
        SeedDatabase.new.exec
      end
    end

    test 'creates example data' do
      response = SeedDatabase.new.exec
      assert(response.ok?)
    end

  end

end
