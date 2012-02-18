# -*- coding: UTF-8 -*-

module Backends

  class Query

    attr_accessor :backend

    class Options
      attr_accessor :from, :where, :where_not, :order
    end

    attr_accessor :options

    def initialize( backend, from )
      self.backend = backend
      self.options = Options.new
      options.from = from
    end

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

    def first
      backend.first( self )
    end

    def all
      backend.all( self )
    end

    def find( id )
      backend.find( self, id )
    end

  end

end
