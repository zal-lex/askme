class RemoveUsernameIdEmailIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :username_id
    remove_column :users, :email_id
  end
end
