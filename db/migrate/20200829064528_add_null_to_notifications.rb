class AddNullToNotifications < ActiveRecord::Migration[5.2]
  def change
    change_column_null :notifications, :user_id, false
    change_column_null :notifications, :variety, false
    change_column_null :notifications, :from_user_id, false
  end
end
