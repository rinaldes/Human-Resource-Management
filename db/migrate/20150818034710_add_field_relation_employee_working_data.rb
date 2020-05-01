class AddFieldRelationEmployeeWorkingData < ActiveRecord::Migration
  def change
  	add_column :employee_working_data, :position_detail, :string
  	add_column :employee_working_data, :contract, :string
  	add_column :employee_working_data, :training_history, :string
  	add_column :employee_working_data, :language_skill, :string
  	add_column :employee_working_data, :skill, :string
  	add_column :employee_working_data, :violation_detail, :string
  end
end
