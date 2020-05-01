class CreateAppraisals < ActiveRecord::Migration
  def change
    create_table :appraisals do |t|
    	t.integer :employee_id
    	t.string :evaluator
    	t.string :periode
    	t.float :total_score
      t.timestamps
    end
  end
end
