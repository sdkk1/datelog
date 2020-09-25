class AddMapInfoToDataspots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :address, :string
    add_column :datespots, :latitude, :float
    add_column :datespots, :longitude, :float
  end
end
