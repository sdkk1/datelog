class RemovePointToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :point, :text
  end
end
