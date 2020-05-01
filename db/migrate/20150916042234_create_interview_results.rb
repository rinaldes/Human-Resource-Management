class CreateInterviewResults < ActiveRecord::Migration
  def change
    create_table :interview_results do |t|
    	t.integer :recruitment_id
    	t.integer :test_result_id
    	t.string :interview_result
    	t.string :status
      t.timestamps
    end
  end
end
