# -*- coding: UTF-8 -*-

require 'app_test_helper'

class NewGuruTest < MiniTest::Spec

  include ::UseCases

  it "returns a new Guru with a default values" do
    response = NewGuru.new.exec
    assert( response.guru )
  end

end
