class AddReferenceUrlToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :reference_url, :string
  end
end
