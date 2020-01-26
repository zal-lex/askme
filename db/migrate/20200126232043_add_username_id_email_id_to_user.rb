class AddUsernameIdEmailIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username_id, :integer, unique: true
    add_column :users, :email_id, :integer, unique: true
  end
end
