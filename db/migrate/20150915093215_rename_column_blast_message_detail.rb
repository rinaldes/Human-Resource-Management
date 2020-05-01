class RenameColumnBlastMessageDetail < ActiveRecord::Migration
  def change
  	rename_column :blast_message_details, :divisi_id, :organization_id
  end
end
