class FixTableAssetsAssignment < ActiveRecord::Migration
  def change
  	remove_column :asset_assignments, :name
  	add_column :asset_assignments, :employee_id, :integer
  	remove_column :asset_assignment_details, :status_assignment
  	add_column :asset_assignment_details, :returned, :boolean, :default => false
  end
end
