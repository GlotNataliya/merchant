class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, default: "consumer", null: false
  end
end
