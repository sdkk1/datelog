class RemovePlaceToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :place, :integer
  end
end
