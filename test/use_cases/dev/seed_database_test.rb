# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class SeedDatabaseTest < MiniTest::Spec

    it "creates example gurus" do
      response = SeedDatabase.new.exec
      assert( response.ok? )
    end

  end

end
