class AddNullToDatespots < ActiveRecord::Migration[5.2]
  def change
    change_column_null :datespots, :address, false
    change_column_null :datespots, :prefecture_code, false
  end
end
