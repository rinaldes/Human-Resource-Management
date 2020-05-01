class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
    	t.integer :employee_id
    	t.string :reason_of_adjustment
    	t.integer :basic
    	t.integer :transport
    	t.date :date_of_performance
    	t.string :from
    	t.string :to
      t.timestamps
    end
  end
end
