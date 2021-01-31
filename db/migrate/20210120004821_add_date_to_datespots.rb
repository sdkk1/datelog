class AddDateToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :date, :datetime
  end
end
