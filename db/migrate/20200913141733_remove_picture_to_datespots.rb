class RemovePictureToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :picture, :string
  end
end
