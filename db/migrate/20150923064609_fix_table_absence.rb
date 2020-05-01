class FixTableAbsence < ActiveRecord::Migration
  def change
  	remove_column :absences, :name
  	remove_column :absences, :organization
  	remove_column :absences, :shift
  	add_column :absences, :employee_id, :integer
  end
end
