class RemovePriceToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :price, :string
  end
end
