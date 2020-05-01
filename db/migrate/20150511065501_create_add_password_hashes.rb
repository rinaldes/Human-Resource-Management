class CreateAddPasswordHashes < ActiveRecord::Migration
   def up
#   add_column :users, :password_hash, :string
   add_index :users, :password_hash, unique: true
  end

  def down
  	remove_index :users, :password_hash
#   remove_column :users, :password_hash
  end
end
