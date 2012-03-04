# -*- coding: UTF-8 -*-

module UseCases

  class NewGuru < UseCase

    def exec
      Response.new(guru: Guru.new)
    end

  end

end
