class AddFieldEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :first_name, :string
  	add_column :employees, :last_name, :string
  	add_column :employees, :gender, :string
  	add_column :employees, :place, :string
  	add_column :employees, :birth, :string
  	add_column :employees, :age, :string
  	# add_column :employees, :status, :string
  	add_column :employees, :religion, :string
  	add_column :employees, :nationality, :string
  	add_column :employees, :email, :string
  end
end
