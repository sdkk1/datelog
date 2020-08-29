class AddNullToDataspots < ActiveRecord::Migration[5.2]
  def change
    change_column_null :datespots, :name, false
    change_column_null :datespots, :keyword, false
    change_column_null :datespots, :user_id, false
    change_column_null :datespots, :place, false
    change_column_null :datespots, :range, false
  end
end
