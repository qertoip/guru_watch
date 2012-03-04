# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module QueryExecutors

    def first
      gateway.first(self)
    end

    def all
      gateway.all(self)
    end

    def find(id)
      gateway.find(id, self)
    end

    def create(attributes = { })
      gateway.create(attributes)
    end

    def create!(attributes = { })
      gateway.create!(attributes)
    end

  end

end
