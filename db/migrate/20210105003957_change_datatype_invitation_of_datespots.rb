class ChangeDatatypeInvitationOfDatespots < ActiveRecord::Migration[5.2]
  def change
    change_column :datespots, :invitation, :string
  end
end
