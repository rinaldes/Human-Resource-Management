class AddEmailCorparateToEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :corporate_email, :string
  end
end
