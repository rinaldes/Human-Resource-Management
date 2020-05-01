class CreateEmployeeResigns < ActiveRecord::Migration
  def change
    create_table :employee_resigns do |t|
    	t.date :date_of_resign
    	t.text :reason_of_resign
    	t.integer :employee_id		
      t.timestamps
    end
  end
end
