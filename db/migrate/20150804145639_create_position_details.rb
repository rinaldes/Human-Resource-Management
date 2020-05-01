class CreatePositionDetails < ActiveRecord::Migration
  def change
    create_table :position_details do |t|
    	t.integer :employee_id
    	t.date 	:start
    	t.date :end
    	t.string :position
    	t.text :organization
    	t.string :reason_for_change
      t.timestamps
    end
  end
end
