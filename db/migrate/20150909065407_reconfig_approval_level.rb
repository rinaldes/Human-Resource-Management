class ReconfigApprovalLevel < ActiveRecord::Migration
  def change
  	remove_column :approval_levels, :user_id
  	remove_column :approval_levels, :features_id
  	add_column :approval_levels, :company_id, :integer
  	add_column :approval_levels, :feature_name, :string
  end
end
