class RemoveAreaToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :area, :string
  end
end
