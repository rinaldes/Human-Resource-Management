class FixFieldAffair < ActiveRecord::Migration
  def change
  	remove_column :affairs, :organization
  	add_column :affairs, :organization_id, :integer
  	remove_column :affairs, :position
  	add_column :affairs, :position_id, :integer
  end
end
