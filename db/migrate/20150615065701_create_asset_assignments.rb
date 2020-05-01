class CreateAssetAssignments < ActiveRecord::Migration
  def change
    create_table :asset_assignments do |t|
    	t.string :name
      t.timestamps
    end
  end
end
