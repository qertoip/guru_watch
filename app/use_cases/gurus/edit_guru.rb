# -*- coding: UTF-8 -*-

module UseCases

  class EditGuru < UseCase

    def exec
      guru = db[Guru].find( request.id )
      Response.new( guru: guru )
    end

  end

end
