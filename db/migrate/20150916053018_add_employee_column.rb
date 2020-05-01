class AddEmployeeColumn < ActiveRecord::Migration
  def change
  	add_column :schedules, :employee_id, :integer
  end
end
