class AddListsCountToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :lists_count, :integer, null: false, default: 0
  end
end
