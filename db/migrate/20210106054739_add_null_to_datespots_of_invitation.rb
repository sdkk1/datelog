class AddNullToDatespotsOfInvitation < ActiveRecord::Migration[5.2]
  def change
    change_column_null :datespots, :invitation, false
  end
end
