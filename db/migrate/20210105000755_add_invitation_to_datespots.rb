class AddInvitationToDatespots < ActiveRecord::Migration[5.2]
  def change
    add_column :datespots, :invitation, :text
  end
end
