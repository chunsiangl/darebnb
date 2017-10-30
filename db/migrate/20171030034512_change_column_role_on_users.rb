class ChangeColumnRoleOnUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :role
  	add_column :users, :role, :integer, default: 0
  end
end
