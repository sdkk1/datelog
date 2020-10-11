class RemoveRateCountToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :rate_count, :float, null: false, default: 0.0
  end
end
