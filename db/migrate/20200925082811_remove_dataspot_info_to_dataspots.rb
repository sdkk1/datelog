class RemoveDataspotInfoToDataspots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :place, :integer
    remove_column :datespots, :latitude, :float
    remove_column :datespots, :longitude, :float
  end
end
