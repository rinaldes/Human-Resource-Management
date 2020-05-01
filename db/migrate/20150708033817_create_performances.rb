class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
    	t.integer :employee_id
    	t.date :date_of_performance
    	t.integer :rating
    	t.string :area_of_strength
    	t.string :area_of_development
    	t.string :rater
    	t.string :position_rater
      t.timestamps
    end
  end
end
