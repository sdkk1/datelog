class AddNullToLists < ActiveRecord::Migration[5.2]
  def change
    change_column_null :lists, :user_id, false
    change_column_null :lists, :datespot_id, false
    change_column_null :lists, :from_user_id, false
  end
end
