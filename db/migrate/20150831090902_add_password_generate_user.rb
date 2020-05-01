class AddPasswordGenerateUser < ActiveRecord::Migration
  def change
  	add_column :users, :password_generate, :string
  end
end
