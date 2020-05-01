class CreateExternalWorkExperiences < ActiveRecord::Migration
  def change
    create_table :external_work_experiences do |t|
    	t.integer :employee_id
			t.string :name_of_company
			t.string :job_desc
			t.string :position
    	t.date 	:start
    	t.date :end
    	t.string :achievement
      t.timestamps
    end
  end
end
