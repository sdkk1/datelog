class AddTimeZoneToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :time_zone, :integer
  end
end
