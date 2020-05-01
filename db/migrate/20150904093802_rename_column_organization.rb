class RenameColumnOrganization < ActiveRecord::Migration
  def change
  	change_column :organizations, :organization_parent, :string
  end
end
