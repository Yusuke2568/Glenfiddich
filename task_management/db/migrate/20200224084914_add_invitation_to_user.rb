class AddInvitationToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invite_digest, :string
    add_column :users, :invite_sent_at, :datetime
    add_column :users, :activated, :boolean, default: false, null: false
    add_column :workspace_members, :activated, :boolean, default: false, null: false
  end
end
