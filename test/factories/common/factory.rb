# -*- encoding : utf-8 -*-

module Factory

  def create_valid!( attributes = {} )
    object = new_valid( attributes )
    object.send( :db ).save!( object )  # hack
    object
  end

  def new_valid( attributes = {} )
    new( valid_attributes.merge( attributes ), :without_protection => true )
  end

end
