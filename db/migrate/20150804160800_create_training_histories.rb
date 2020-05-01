class CreateTrainingHistories < ActiveRecord::Migration
  def change
    create_table :training_histories do |t|
    	t.integer :employee_id
    	t.string :training_type
    	t.date :start
    	t.date :end
    	t.string :sponsor
    	t.string :result
      t.timestamps
    end
  end
end
