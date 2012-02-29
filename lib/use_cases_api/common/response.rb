# -*- coding: UTF-8 -*-

module UseCases

  class Response < OpenStruct

    def ok?
      !errors
    end

  end

end
