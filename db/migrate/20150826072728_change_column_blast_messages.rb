class ChangeColumnBlastMessages < ActiveRecord::Migration
  def change
  	rename_column :blast_messages, :email_id, :sender_id
  	add_column :blast_messages, :sender_type, :string
  	add_column :blast_messages, :name, :string
  end
end