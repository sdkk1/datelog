class AddFollowedCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :followed_count, :integer, null: false, default: 0
  end
end
