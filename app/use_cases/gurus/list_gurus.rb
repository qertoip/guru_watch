# -*- coding: UTF-8 -*-

module UseCases

  class ListGurus < UseCase

    def exec
      gurus = db.from( :gurus ).all
      Response.new( :gurus => gurus )
    end

  end

end
