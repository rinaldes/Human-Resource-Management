class AddColumnBlastMessageDetail < ActiveRecord::Migration
  def change
  	add_column :blast_message_details, :employee_id, :integer
  	add_column :blast_message_details, :divisi_id, :integer
  end
end
