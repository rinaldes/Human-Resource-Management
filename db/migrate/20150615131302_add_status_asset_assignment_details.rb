class AddStatusAssetAssignmentDetails < ActiveRecord::Migration
  def change

  	add_column :asset_assignment_details, :status_assignment, :string
  end
end
