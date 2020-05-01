class CreateEducationDetails < ActiveRecord::Migration
  def change
    create_table :education_details do |t|
			t.integer :employee_id
			t.string :grade
			t.string :institution
    	t.date 	:start
    	t.date :end
    	t.string :major
    	t.integer :final_score
      t.timestamps
    end
  end
end
