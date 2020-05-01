class CreateAppraisalValues < ActiveRecord::Migration
  def change
    create_table :appraisal_values do |t|
    	t.integer :appraisal_id
    	t.string :value
    	t.float :bobot
      t.timestamps
    end
  end
end
