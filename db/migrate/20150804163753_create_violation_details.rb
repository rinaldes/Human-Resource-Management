class CreateViolationDetails < ActiveRecord::Migration
  def change
    create_table :violation_details do |t|
    	t.integer :employee_id
    	t.string :violation_type
    	t.string :violation_description
    	t.date :start
    	t.date :due_date
    	t.string :punishment
      t.timestamps
    end
  end
end
