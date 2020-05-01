class CreateEmployeeWorkingData < ActiveRecord::Migration
  def change
    create_table :employee_working_data do |t|
    	

      t.timestamps
    end
  end
end
