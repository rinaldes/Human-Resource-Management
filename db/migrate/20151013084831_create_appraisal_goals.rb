class CreateAppraisalGoals < ActiveRecord::Migration
  def change
    create_table :appraisal_goals do |t|
    	t.integer :appraisal_id
    	t.string :goal
    	t.float :bobot
      t.timestamps
    end
  end
end
