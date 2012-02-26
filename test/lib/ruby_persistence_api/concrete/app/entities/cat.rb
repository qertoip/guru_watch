# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Entities

    class Cat < Entity
      attribute :id, :type => Integer
      attribute :name, :type => String
    end

  end

end
