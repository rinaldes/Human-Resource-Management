class CreateAppraisalComponents < ActiveRecord::Migration
  def change
    create_table :appraisal_components do |t|
    	t.integer :appraisal_id
    	t.string :component
    	t.float :bobot
      t.timestamps
    end
  end
end
