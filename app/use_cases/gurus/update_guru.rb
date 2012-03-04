# -*- coding: UTF-8 -*-

module UseCases

  class UpdateGuru < UseCase

    def exec
      guru = db[Guru].find(request.id)

      if db[guru].update_attributes(request.atts)
        Response.new(guru: guru)
      else
        Response.new(guru: guru, errors: guru.errors)
      end
    end

  end

end
