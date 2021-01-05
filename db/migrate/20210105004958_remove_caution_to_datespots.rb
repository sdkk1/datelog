class RemoveCautionToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :caution, :text
  end
end
