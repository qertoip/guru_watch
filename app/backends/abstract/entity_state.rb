# -*- coding: UTF-8 -*-

module Backends

  module EntityState

    def persisted?
      !(new_record? || destroyed?)
    end

    def new_record?
      id.nil?  # TODO: this assumes only db manages ids
    end

    def destroyed?
      @destroyed
    end

  end

end
