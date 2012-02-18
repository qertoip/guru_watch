# -*- coding: UTF-8 -*-

module Entities

  class Guru < Entity

    attr_accessor   :id, :name, :homepage, :description
    attr_persistent :id, :name, :homepage, :description

    validates :name, :presence => true, :uniqueness => true

  end

end
