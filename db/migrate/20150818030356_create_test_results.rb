class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
    	t.string :applicant_name
    	t.string :attachment
    	t.string :position
    	t.integer :score
    	t.string :status

      t.timestamps
    end
  end
end
