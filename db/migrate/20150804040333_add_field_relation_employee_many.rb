class AddFieldRelationEmployeeMany < ActiveRecord::Migration
  def change
  	add_column :address_informations, :employee_id, :integer
  end
end
