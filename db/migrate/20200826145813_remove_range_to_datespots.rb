class RemoveRangeToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :range, :integer
  end
end
