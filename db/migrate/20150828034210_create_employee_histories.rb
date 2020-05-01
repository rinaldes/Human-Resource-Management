class CreateEmployeeHistories < ActiveRecord::Migration
  def change
    create_table :employee_histories do |t|
    	t.integer :employee_id
    	t.string :education_detail
    	t.string :external_work_experience
    	t.string :internal_work_experience
    	t.string :history_of_organization
    	t.string :certification
      t.timestamps
    end
  end
end
