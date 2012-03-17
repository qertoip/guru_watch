class CreateGurus < ActiveRecord::Migration
  def up
    create_table :gurus do |t|
      t.string :name, :null => false
      t.string :homepage
      t.text :description
    end
  end

  def down
    drop_table :gurus
  end
end
