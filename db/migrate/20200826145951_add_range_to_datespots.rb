class AddRangeToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :range, :integer
  end
end
