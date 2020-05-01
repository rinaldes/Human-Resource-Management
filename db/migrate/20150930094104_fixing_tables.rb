class FixingTables < ActiveRecord::Migration
  def change
  	rename_column :recruitments , :organization , :organization_id
  end
end
