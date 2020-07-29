class CreateDatespots < ActiveRecord::Migration[5.2]
  def change
    create_table :datespots do |t|
      t.string :name
      t.string :area
      t.string :price
      t.text :keyword
      t.text :point
      t.text :caution
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :datespots, [:user_id, :created_at]
  end
end
