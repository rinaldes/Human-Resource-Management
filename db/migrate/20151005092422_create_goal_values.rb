class CreateGoalValues < ActiveRecord::Migration
  def change
    create_table :goal_values do |t|
    	t.string :value
      t.timestamps
    end
  end
end
