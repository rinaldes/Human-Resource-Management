class ChangeOrganizationIdFromStringToInt < ActiveRecord::Migration
  def change
  	remove_column :recruitments , :organization_id , :string
  	add_column :recruitments , :organization_id , :integer
  end
end
