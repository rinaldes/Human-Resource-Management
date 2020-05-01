class CreateInternalWorkExperiences < ActiveRecord::Migration
  def change
    create_table :internal_work_experiences do |t|
    	t.integer :employee_id
			t.string :name_of_company
			t.string :job_desc
			t.string :position
			t.text :organization
    	t.date 	:start
    	t.date :end
    	t.string :achievement
      t.timestamps
    end
  end
end
