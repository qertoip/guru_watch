# -*- encoding : utf-8 -*-

module Factory

  def create_valid!(attributes = { })
    object = new_valid(attributes)
    db = Application.instance.config.backend
    db[object].save!
    object
  end

  def new_valid(attributes = { })
    new(valid_attributes.merge(attributes), without_protection: true)
  end

end
