class AddDatespotsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :datespots_count, :integer, null: false, default: 0
  end
end
