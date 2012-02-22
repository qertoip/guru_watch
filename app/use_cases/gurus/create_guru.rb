# -*- coding: UTF-8 -*-

module UseCases

  class CreateGuru < UseCase

    def exec
      guru = Guru.new( request.atts )
      response = Response.new( :guru => guru )

      if guru.valid?
        db[guru].save
      else
        response.errors = guru.errors
      end

      response
    end

  end

end
