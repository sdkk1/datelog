class AddPlanToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :plan, :text
  end
end
