# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class UseCaseTest < GuruWatch::TestCase

    class ConcreteUseCase < UseCase;
    end

    test 'initializes with a Request' do
      request = Request.new(x: 2)
      concrete_use_case = ConcreteUseCase.new(request)
      assert_equal(2, concrete_use_case.request.x)
    end

    test 'initializes with a Hash' do
      concrete_use_case = ConcreteUseCase.new(x: 2)
      assert_equal(2, concrete_use_case.request.x)
    end

  end

end
