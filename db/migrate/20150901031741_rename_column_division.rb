class RenameColumnDivision < ActiveRecord::Migration
  def change
  	rename_column :divisions, :name, :description
  	rename_column :divisions, :divisi_id, :name
  end
end
