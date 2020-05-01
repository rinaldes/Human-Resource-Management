class CreateScheduleDetails < ActiveRecord::Migration
  def change
    create_table :schedule_details do |t|
    	t.integer :schedule_id
    	t.integer :employee_id
      t.timestamps
    end
  end
end
