class ChangeNameRateCountOfDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :rate_average, :float, default: 0.0
  end
end
