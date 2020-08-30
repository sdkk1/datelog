class RemoveKeywordToDatespots < ActiveRecord::Migration[5.2]
  def change
    remove_column :datespots, :keyword, :text
  end
end
