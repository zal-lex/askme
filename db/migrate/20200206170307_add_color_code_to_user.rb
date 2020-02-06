class AddColorCodeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :color_code, :string
  end
end
