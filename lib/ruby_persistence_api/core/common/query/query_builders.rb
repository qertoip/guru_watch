# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module QueryBuilders

    def where( conditions )
      options.where = conditions
      self
    end

    def where_not( conditions )
      options.where_not = conditions
      self
    end

    def order( hash )
      options.order = hash
      self
    end

  end

end
