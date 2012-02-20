# -*- coding: UTF-8 -*-

module Backends

  module QueryExecutors

    def first
      gateway.first( self )
    end

    def all
      gateway.all( self )
    end

    def find( id )
      gateway.find( id, self )
    end

  end

end
