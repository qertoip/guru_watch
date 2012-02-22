# -*- coding: UTF-8 -*-

module UseCases

  class UseCase

    include ::Entities

    attr_accessor :request

    def initialize( request_or_hash = {} )
      if request_or_hash.is_a?( Hash )
        self.request = Request.new( request_or_hash )
      else
        self.request = request_or_hash
      end
    end

    private

      def db
        GuruWatch.instance.config.backend
      end

  end

end
