# -*- coding: UTF-8 -*-

module Entities

  class Entity
    include ActiveAttr::Model         # Make PORO objects feel like ActiveRecord models

    include Backends::Validations     # UniquenessValidator
    include Backends::EntityState     # Adds #persisted?
  end

end
