class CreateAddRoles < ActiveRecord::Migration
 def up
  add_column :users, :role, :string
  add_index :users, :role #, default: ""
  end

  def down
	  remove_index :users, :role
	  remove_column :users, :role
  end
end
