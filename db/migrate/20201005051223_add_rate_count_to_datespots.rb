class AddRateCountToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :rate_count, :float, null: false, default: 0.0
  end
end
