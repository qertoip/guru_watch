# -*- coding: UTF-8 -*-

module UseCases

  class CreateGuru < UseCase

    def exec
      guru = Guru.new( request.atts )

      if guru.valid?
        db[guru].save
        Response.new( guru: guru )
      else
        Response.new( guru: guru, errors: guru.errors )
      end
    end

  end

end
