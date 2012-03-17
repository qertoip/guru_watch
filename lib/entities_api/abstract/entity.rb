# -*- coding: UTF-8 -*-

require 'active_model'
require 'active_attr'
require_relative '../../validations/uniqueness'

module Entities

  class Entity
    include ActiveAttr::Model # Make PORO objects feel like ActiveRecord models

    include Validations # UniquenessValidator

    def persisted?
      !(new_record? || destroyed?)
    end

    def new_record?
      id.nil? # TODO: this assumes only db manages ids
    end

    def destroyed?
      @destroyed
    end

  end

end
