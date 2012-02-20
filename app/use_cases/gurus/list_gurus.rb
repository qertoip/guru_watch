# -*- coding: UTF-8 -*-

module UseCases

  class ListGurus < UseCase

    def exec
      gurus = db.objects( Guru ).all
      Response.new( :gurus => gurus )
    end

  end

end
