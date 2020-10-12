class AddPrefectureCodeToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :prefecture_code, :integer
  end
end
