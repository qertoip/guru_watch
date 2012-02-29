# -*- coding: UTF-8 -*-

module UseCases

  class ListGurus < UseCase

    def exec
      gurus = db[Guru].all
      Response.new( gurus: gurus )
    end

  end

end
