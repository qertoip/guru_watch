# -*- coding: UTF-8 -*-

module Entities

  class Guru < Entity

    attribute :id,   :type => Integer
    attribute :name, :type => String
    attribute :homepage, :type => String
    attribute :description, :type => String

    validates :name, :presence => true, :uniqueness => true

  end

end
