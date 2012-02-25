# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Entities

    class Dog < Entity
      attribute :id, :type => Integer
      attribute :name, :type => String
      attribute :age, :type => Integer

      validates :name, :presence => true
    end

  end

end
