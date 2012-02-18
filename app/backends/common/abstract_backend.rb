# -*- coding: UTF-8 -*-

module Backends

  class AbstractBackend

    def from( objects )
      Query.new( self, objects )
    end

  end

end
