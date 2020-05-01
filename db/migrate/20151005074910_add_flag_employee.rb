class AddFlagEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :flag_employee, :boolean, :default => true
  end
end
