# -*- coding: UTF-8 -*-

module UseCases

  class DestroyGuru < UseCase

    def exec
      guru = db[Guru].find(request.id)
      db[guru].destroy
      Response.new
    end

  end

end
