# -*- coding: UTF-8 -*-

require_relative 'query_options'
require_relative 'query_builders'
require_relative 'query_executors'

module Backends

  class Query

    include QueryBuilders
    include QueryExecutors

    attr_accessor :gateway, :options

    def initialize( gateway )
      self.gateway = gateway
      self.options = QueryOptions.new
    end

  end

end
