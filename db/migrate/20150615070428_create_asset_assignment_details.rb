class CreateAssetAssignmentDetails < ActiveRecord::Migration
  def change
    create_table :asset_assignment_details do |t|
    	t.integer :asset_assignment_id
    	t.string :asset_type
    	t.string :name
    	t.string :serial_number
    	t.date :date
      t.timestamps
    end
  end
end
