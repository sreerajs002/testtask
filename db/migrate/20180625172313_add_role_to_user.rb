class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer
    add_column :users, :name, :string
  end
end
