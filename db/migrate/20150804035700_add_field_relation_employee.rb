class AddFieldRelationEmployee < ActiveRecord::Migration
  def change
  	add_column :healths, :employee_id, :integer
  	add_column :affairs, :employee_id, :integer
  	add_column :emergency_kontaks, :employee_id, :integer
  	add_column :contacts_numbers, :employee_id, :integer
  end
end
