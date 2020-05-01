class AddEmailIdToBlastMessage < ActiveRecord::Migration
  def change
  	add_column :blast_messages, :email_id, :integer
  end
end
